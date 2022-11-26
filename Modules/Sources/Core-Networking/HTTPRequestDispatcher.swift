import Combine
import Core_Networking_Interface
import Foundation

public struct HTTPRequestDispatcher: HTTPRequestDispatcherProtocol {
    private let session: URLSessionProtocol
    private let requestBuilder: RequestBuilderProtocol
    private let decoder: JSONDecoder

    public init(
        session: URLSessionProtocol = URLSession.shared,
        requestBuilder: RequestBuilderProtocol = DefaultRequestBuilder(),
        decoder: JSONDecoder = .init()
    ) {
        self.session = session
        self.requestBuilder = requestBuilder
        self.decoder = decoder
    }

    public func dataPublisher<Response: Decodable>(
        for request: HTTPRequestProtocol
    ) -> AnyPublisher<Response, HTTPRequestError> {
        do {
            let urlRequest = try requestBuilder.build(from: request)
            return session
                .anyDataTaskPublisher(for: urlRequest)
                .decode(type: Response.self, decoder: decoder)
                .mapError { _ in HTTPRequestError.networking }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: HTTPRequestError.requestSerialization)
                .eraseToAnyPublisher()
        }
    }
}
