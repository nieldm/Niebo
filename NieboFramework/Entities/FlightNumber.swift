import Foundation
import Then

public struct FlightNumber: Codable, Then {
    public var number: String
    public var carrierId: Int
    
    public var carrier: Carrier?
    
    enum CodingKeys: String, CodingKey
    {
        case number = "FlightNumber"
        case carrierId = "CarrierId"
    }
}
