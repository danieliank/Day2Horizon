import Foundation

struct Trip: Identifiable {
    
    let id = UUID()
    
    var name: String
    var photoName: String
    var scheduledDate: Date
    var activities: [Activity]
    
}
