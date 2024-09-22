import SwiftUI

struct WorkoutListView: View {
    @State private var workouts: [Workout] = []
    @State private var errorMessage = ""
    let token: String

    var body: some View {
        List(workouts) { workout in
            VStack(alignment: .leading) {
                Text("Date: \(workout.date)")
                Text("Duration: \(workout.duration)")
                Text("Calories Burned: \(workout.caloriesBurned)")
            }
        }
        .onAppear {
            APIService.shared.fetchWorkouts(token: token) { result in
                switch result {
                case .success(let workouts):
                    self.workouts = workouts
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
