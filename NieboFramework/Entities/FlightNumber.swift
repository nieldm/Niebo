import Foundation

public struct FlightNumber: Codable {
    public var number: String
    public var carrierId: Int
    
    enum CodingKeys: String, CodingKey
    {
        case number = "FlightNumber"
        case carrierId = "CarrierId"
    }
}
