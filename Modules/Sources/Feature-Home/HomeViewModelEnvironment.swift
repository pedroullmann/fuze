import Foundation

public struct HomeViewModelEnvironment {
    public init() {}
}

#if DEBUG
public extension HomeViewModelEnvironment {
    static func fixture() -> Self {
        .init()
    }
}
#endif
