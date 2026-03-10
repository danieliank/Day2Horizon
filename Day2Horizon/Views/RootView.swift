import SwiftUI

struct RootView: View {
    
    @State var trips: [Trip]
    @State private var showAddTrip = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(Array(trips.enumerated()), id: \.element.id) { index, trip in
                        TripCardView(trip: $trips[index])
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    deleteTrip(at: index)
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .padding(8)
                                }
                                .foregroundStyle(.white)
                                .background(.red)
                                .clipShape(Circle())
                                .padding(8)
                            }
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
    
    
    func deleteTrip(at index: Int) {
        trips.remove(at: index)
    }
}

#Preview {
    RootView(
        trips: [
            Trip(
                name: "Cali Coastal Trails",
                photoData: nil,
                scheduledDate: .now,
                activities: [
                    Activity(name: "Bumpy ride across the ridges", isComplete: false),
                    Activity(name: "Sandboard", isComplete: false)
                ]
            )
        ]
    )
}
