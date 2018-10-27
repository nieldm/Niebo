import Foundation

public struct Agent: Codable {
    public var id: Int
    public var name: String
    public var imageUrl: String
    public var status: Status = .other
    public var optimisedForMobile: Bool
    public var type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case status = "Status"
        case optimisedForMobile = "OptimisedForMobile"
        case type = "Type"
    }
}
