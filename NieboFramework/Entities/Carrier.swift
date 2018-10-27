import Foundation

public struct Carrier: Codable {
    public var id: Int
    public var code: String
    public var name: String
    public var imageUrl: String
    public var displayCode: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case code = "Code"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case displayCode = "DisplayCode"
    }
    
    
}
