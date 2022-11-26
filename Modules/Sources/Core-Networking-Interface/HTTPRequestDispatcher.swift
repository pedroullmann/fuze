import Foundation
import Combine

public protocol HTTPRequestDispatcherProtocol {
    func dataPublisher<Response: Decodable>(
        for request: HTTPRequestProtocol
    ) -> AnyPublisher<Response, HTTPRequestError>
}
