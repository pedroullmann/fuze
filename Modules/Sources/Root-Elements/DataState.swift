import Foundation

public enum DataState<Model: Equatable>: Equatable {
    case loading
    case loaded(Model)
    case error
}
