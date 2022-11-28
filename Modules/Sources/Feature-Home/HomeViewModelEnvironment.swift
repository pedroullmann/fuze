import Combine
import CombineSchedulers
import Foundation
import Feature_Home_Repository
import Feature_MatchDetails_Repository

public struct HomeViewModelEnvironment {
    let service: HomeService
    let matchDetailsService: MatchDetailsService
    let scheduler: AnySchedulerOf<DispatchQueue>

    public init(
        service: HomeService,
        matchDetailsService: MatchDetailsService,
        scheduler: AnySchedulerOf<DispatchQueue> = .main.eraseToAnyScheduler()
    ) {
        self.service = service
        self.matchDetailsService = matchDetailsService
        self.scheduler = scheduler
    }
}

#if DEBUG
public extension HomeViewModelEnvironment {
    static func fixture(
        service: HomeService = .failing,
        matchDetailsService: MatchDetailsService = .failing,
        scheduler: AnySchedulerOf<DispatchQueue> = .immediate.eraseToAnyScheduler()
    ) -> Self {
        .init(
            service: service,
            matchDetailsService: matchDetailsService,
            scheduler: scheduler
        )
    }
}
#endif
