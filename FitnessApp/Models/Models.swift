import Foundation

// Workout model conforming to Codable and Identifiable
struct Workout: Codable, Identifiable {
    let id: Int
    let date: String
    let duration: String
    let caloriesBurned: Int
    
    // Use CodingKeys to map between JSON keys and Swift variable names
    enum CodingKeys: String, CodingKey {
        case id, date, duration
        case caloriesBurned = "calories_burned"
    }
}
