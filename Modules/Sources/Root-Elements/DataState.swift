import Foundation

public enum DataState<Model: Equatable>: Equatable {
    case loading
    case loaded(Model)
    case error

    public var model: Model? {
        guard case let .loaded(model) = self else {
            return nil
        }
        return model
    }
}
