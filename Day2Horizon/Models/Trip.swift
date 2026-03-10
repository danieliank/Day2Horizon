import Foundation

struct Trip: Identifiable {
    
    let id = UUID()
    
    var name: String
    var photoData: Data?
    var scheduledDate: Date
    var activities: [Activity]
    
}
