import SwiftUI

struct RootView: View {
    
    @State var trips: [Trip]
    @State private var showAddTrip = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach($trips) { $trip in
                        TripCardView(trip: $trip)
                    }
                }
                .padding()
            }
            .navigationTitle("Trips")
            .toolbar {
                Button {
                    showAddTrip = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddTrip) {
                AddTripView(trips: $trips)
            }
        }
        
    }
}

#Preview {
    RootView(
        trips: [
            Trip(
                name: "Cali Coastal Trails",
                photoName: "Cali",
                scheduledDate: .now,
                activities: [
                    Activity(name: "Bumpy ride across the ridges", isComplete: false),
                    Activity(name: "Sandboard", isComplete: false)
                ]
            )
        ]
    )
}
