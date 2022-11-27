import Combine
import CombineSchedulers
import Foundation
import Feature_Home_Repository

public struct HomeViewModelEnvironment {
    let service: HomeService
    let scheduler: AnySchedulerOf<DispatchQueue>

    public init(
        service: HomeService,
        scheduler: AnySchedulerOf<DispatchQueue> = .main.eraseToAnyScheduler()
    ) {
        self.service = service
        self.scheduler = scheduler
    }
}

#if DEBUG
public extension HomeViewModelEnvironment {
    static func fixture(
        service: HomeService = .failing,
        scheduler: AnySchedulerOf<DispatchQueue> = .immediate.eraseToAnyScheduler()
    ) -> Self {
        .init(
            service: service,
            scheduler: scheduler
        )
    }
}
#endif
