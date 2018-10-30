import Foundation
import Moya

public enum SKYPricesAPI {
    case pricing
    case results(url: String?, pageIndex: Int)
}

extension SKYPricesAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "http://partners.api.skyscanner.net")!
    }
    
    public var path: String {
        switch self {
        case .pricing:
            return "/apiservices/pricing/v1.0"
        case .results(let rawUrl, _):
            guard let rawUrl = rawUrl,
                let url = URL(string: rawUrl) else {
                return ""
            }
            return url.path
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .pricing:
            return Method.post
        case .results(_, _):
            return Method.get
        }
    }
    
    public var sampleData: Data {
        var fileName: String?
        switch self {
        case .results(_, _):
            fileName = "pricesPoll"
        default: return Data()
        }
        guard let
            path = Bundle.main.path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
        }
        return data
    }
    
    public var task: Task {
        var parameters = [String: Any]()
        switch self {
        case .pricing:
            parameters["country"] = "CO"
            parameters["currency"] = "COP"
            parameters["locale"] = "es-CO"
            parameters["locationSchema"] = "sky"
            parameters["originPlace"] = "EDI-sky"
            parameters["destinationPlace"] = "LOND-sky"
            parameters["outboundDate"] = "2018-11-16"
        case .results(_, let pageIndex):
            parameters["pageIndex"] = pageIndex
        }
        parameters["apiKey"] = "ss630745725358065467897349852985"
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
