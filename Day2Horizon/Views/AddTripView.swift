import SwiftUI

struct AddTripView: View {
    
    @Binding var trips: [Trip]
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var photoName = ""
    @State private var date = Date()
    @State private var activities: [Activity] = []
    @State private var newActivityName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Trip Info") {
                    TextField("Trip Name", text: $name)
                    TextField("Photo Asset Name", text: $photoName)
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
    }
    
    func addActivity() {
        let activity = Activity(
            name: newActivityName,
            isComplete: false
        )
        activities.append(activity)
        newActivityName = ""
    }
    
    func addTrip() {
        let newTrip = Trip(
            name: name,
            photoName: photoName,
            scheduledDate: date,
            activities: activities
        )
        trips.append(newTrip)
        dismiss()
    }
}
