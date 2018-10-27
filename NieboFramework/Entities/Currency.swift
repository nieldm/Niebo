import Foundation

public struct Currency: Codable {
    public var code: String
    public var symbol: String
    public var thousandsSeparator: String
    public var decimalSeparator: String
    public var symbolOnLeft: Bool
    public var spaceBetweenAmountAndSymbol: Bool
    public var roundingCoefficient: Int
    public var decimalDigits: Int
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case symbol = "Symbol"
        case thousandsSeparator = "ThousandsSeparator"
        case decimalSeparator = "DecimalSeparator"
        case symbolOnLeft = "SymbolOnLeft"
        case spaceBetweenAmountAndSymbol = "SpaceBetweenAmountAndSymbol"
        case roundingCoefficient = "RoundingCoefficient"
        case decimalDigits = "DecimalDigits"
    }
}
