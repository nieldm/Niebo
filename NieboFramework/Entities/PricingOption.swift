import Foundation
import Then

public struct PricingOption: Codable, Then {
    public var quoteAgeInMinutes: Int
    public var price: Float
    public var deepLink: String
    public var agentIds: [Int]
    
    public var agents: [Agent] = []
    
    enum CodingKeys: String, CodingKey
    {
        case quoteAgeInMinutes = "QuoteAgeInMinutes"
        case price = "Price"
        case deepLink = "DeeplinkUrl"
        case agentIds = "Agents"
    }
}
