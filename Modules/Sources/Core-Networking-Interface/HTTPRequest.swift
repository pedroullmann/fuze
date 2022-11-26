import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public enum HTTPRequestParameters {
    case urlQuery([String: String])
    case requestPlain
}

public protocol HTTPRequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: HTTPRequestParameters { get }
    var headers: [String: String]? { get }
}

public extension HTTPRequestProtocol {
    var baseURL: URL {
        URL(string: "https://api.pandascore.co")!
    }

    var parameters: HTTPRequestParameters {
        .requestPlain
    }

    var headers: [String: String]? {
        ["Authorization": "Bearer QUVRmcO2kKhsprWtSXyHoPGHaJw8iGWwM8M_nKAE7dcbXasmiPk"]
    }
}
