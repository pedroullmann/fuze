import Foundation

public enum HTTPRequestError: Error, Equatable {
    case networking
    case requestSerialization
}
