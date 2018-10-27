import Foundation

public enum PlaceType: String, Codable {
    case airport = "Airport"
    case country = "Country"
    case city = "City"
    case other
}

public struct Place: Codable {
    public var id: Int
    public var parentId: Int?
    public var code: String
    public var type: PlaceType = .other
    public var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case parentId = "ParentId"
        case code = "Code"
        case type = "Type"
        case name = "Name"
    }
}
