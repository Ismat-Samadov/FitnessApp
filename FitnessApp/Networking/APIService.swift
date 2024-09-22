import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "http://127.0.0.1:8000/api/"  // Change this to your actual API URL

    // MARK: - User Registration
    func registerUser(username: String, password: String, email: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)register/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let userDetails = ["username": username, "password": password, "email": email]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userDetails, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            }
        }.resume()
    }

    // MARK: - User Login
    func loginUser(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)login/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginDetails = ["username": username, "password": password]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: loginDetails, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let token = json["token"] as? String {
                    completion(.success(token))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid token"])))
                }
            }
        }.resume()
    }

    // MARK: - Fetch Workouts
    func fetchWorkouts(token: String, completion: @escaping (Result<[Workout], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)workouts/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let workouts = try JSONDecoder().decode([Workout].self, from: data)
                    completion(.success(workouts))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

