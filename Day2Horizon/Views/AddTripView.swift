import SwiftUI
import PhotosUI

struct AddTripView: View {
    
    @Binding var trips: [Trip]
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var date = Date()
    @State private var activities: [Activity] = []
    @State private var newActivityName = ""
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var photoData: Data?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Trip Info") {
                    TextField("Trip Name", text: $name)
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        
                        if let photoData,
                           let uiImage = UIImage(data: photoData) {
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 150)
                                .clipped()
                        } else {
                            Label("Select Photo", systemImage: "photo")
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section("Activities") {
                    HStack {
                        TextField("New Activity", text: $newActivityName)
                        Button("Add") {
                            addActivity()
                        }
                        .disabled(newActivityName.isEmpty)
                    }
                    ForEach(activities) { activity in
                        Text(activity.name)
                    }
                }
            }
            .navigationTitle("Add Trip")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addTrip()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    photoData = data
                }
                print("Photo Shown")
            }
        }
    }
    
    func addActivity() {
        let activity = Activity(
            name: newActivityName,
            isComplete: false
        )
        activities.append(activity)
        newActivityName = ""
        debugPrint("Actxivity added")
    }
    
    func addTrip() {
        let newTrip = Trip(
            name: name,
            photoData: photoData,
            scheduledDate: date,
            activities: activities
        )
        trips.append(newTrip)
        dismiss()
        debugPrint("Trip added")
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
