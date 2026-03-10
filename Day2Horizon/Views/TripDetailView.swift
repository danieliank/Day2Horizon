import SwiftUI

struct TripDetailView: View {
    
    @Binding var trip: Trip
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if UIImage(named: trip.photoName) != nil {
                    Image(trip.photoName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(trip.name)
                        .font(.largeTitle.bold())
                    Text(trip.scheduledDate.formatted(date: .long, time: .omitted))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Divider()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Activities")
                        .font(.title2.bold())
                    if trip.activities.isEmpty {
                        Text("No activities yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach($trip.activities) { $activity in
                            Toggle(isOn: $activity.isComplete) {
                                Text(activity.name)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
