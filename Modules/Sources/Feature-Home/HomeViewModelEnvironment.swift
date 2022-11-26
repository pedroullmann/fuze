import Foundation
import Feature_Home_Repository

public struct HomeViewModelEnvironment {
    let service: HomeService

    public init(service: HomeService) {
        self.service = service
    }
}

#if DEBUG
public extension HomeViewModelEnvironment {
    static func fixture(
        service: HomeService = .failing
    ) -> Self {
        .init(service: service)
    }
}
#endif
