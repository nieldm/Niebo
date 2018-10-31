import Foundation
import Moya

public enum FilterOption {
    case direct
}

public enum SortOption: String {
    case duration
    case price
}

public enum SortModifier: String {
    case ascendant = "asc"
    case descendant = "desc"
}

public enum SKYPricesAPI {
    case pricing
    case results(url: String?, pageIndex: Int, sortOption: SortOption?, sortModifier: SortModifier?, filter: FilterOption?)
}

extension SKYPricesAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "http://partners.api.skyscanner.net")!
    }
    
    public var path: String {
        switch self {
        case .pricing:
            return "/apiservices/pricing/v1.0"
        case .results(let rawUrl, _, _, _, _):
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
        case .results(_, _, _, _, _):
            return Method.get
        }
    }
    
    public var sampleData: Data {
        var fileName: String?
        switch self {
        case .results(_, _, _, _, _):
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
            parameters["inboundDate"] = "2018-12-24"
        case .results(_, let pageIndex, let sortOption, let sortModifier, let filterOption):
            parameters["pageIndex"] = pageIndex
            if let sortOption = sortOption {
                parameters["sortType"] = sortOption.rawValue
            }
            if let sortModifier = sortModifier {
                parameters["sortOrder"] = sortModifier.rawValue
            }
            if let filterOption = filterOption {
                switch filterOption {
                case .direct:
                    parameters["stops"] = 0
                }
            }
        }
        parameters["apiKey"] = "ss630745725358065467897349852985"
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
