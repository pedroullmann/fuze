import Core_Networking_Interface
import Foundation

protocol RequestBuilderProtocol {
    func build(from request: HTTPRequestProtocol) throws -> URLRequest
}

struct DefaultRequestBuilder: RequestBuilderProtocol {
    func build(from request: HTTPRequestProtocol) throws -> URLRequest {
        let endpoint = request.baseURL.appendingPathComponent(request.path)

        var urlRequest: URLRequest = .init(url: endpoint)
        urlRequest.httpMethod = request.method.rawValue
        request.headers?.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }

        if case let .urlQuery(parameters) = request.parameters {
            guard var urlComponents = URLComponents(
                url: endpoint,
                resolvingAgainstBaseURL: true
            ) else {
                return urlRequest
            }
            urlComponents.queryItems = parameters.map { .init(name: $0.key, value: $0.value) }
            urlRequest.url = urlComponents.url
        }

        return urlRequest
    }
}
