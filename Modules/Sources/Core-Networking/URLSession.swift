import Foundation
import Combine

public protocol URLSessionProtocol {
    func anyDataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data, Error>
}

extension URLSession: URLSessionProtocol {
    public func anyDataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data, Error> {
        dataTaskPublisher(for: request)
            .tryMap(\.data)
            .eraseToAnyPublisher()
    }
}
