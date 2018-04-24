import Alamofire
import Moya

// i.e, http://api.aladhan.com/v1/calendar?latitude=51.508515&longitude=-0.1254872&method=3&month=4&year=2018

enum UnauthenticatedEndpoints {
    case getAzkarTimes(latitude: Double, longitude: Double, method: Int, month: Int, year: Int)
}

extension UnauthenticatedEndpoints: TargetType {
    var baseURL: URL {
        switch self {
        case .getAzkarTimes:
            return URL(string: "http://api.aladhan.com/v1/calendar")!
        }
    }

    var path: String {
        switch self {
        case .getAzkarTimes:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAzkarTimes:
            return .get
        }
    }

    var sampleData: Data {
        switch self {
        case .getAzkarTimes:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case let .getAzkarTimes(latitude, longitude, method, month, year):
            return .requestParameters(parameters: ["latitude": latitude, "longitude": longitude, "method": method, "month": month, "year": year], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
