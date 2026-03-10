import SwiftUI

struct TripCardView: View {
    
    @Binding var trip: Trip
    
    var body: some View {
        
        NavigationLink {
            TripDetailView(trip: $trip)
        } label: {
            ZStack(alignment: .bottomLeading) {
                if let data = trip.photoData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .clipped()
                } else {
                    ZStack {
                        Color.gray.opacity(0.25)

                        VStack(spacing: 8) {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                            Text("No Photo")
                                .font(.caption)
                        }
                        .foregroundStyle(.secondary)
                    }
                    .frame(height: 180)
                }
                LinearGradient(
                    colors: [.black.opacity(0.7), .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                VStack(alignment: .leading) {
                    Text(trip.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text(trip.scheduledDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                }
                .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    PreviewContainer()
}
struct PreviewContainer: View {
    
    @State var trip = Trip(
        name: "Cali Coastal Trails",
        photoData: nil,
        scheduledDate: .now,
        activities: [
            Activity(name: "Bumpy ride across the ridges", isComplete: false),
            Activity(name: "Sandboard", isComplete: true)
        ]
    )
    
    var body: some View {
        TripCardView(trip: $trip)
            .padding()
    }
}
