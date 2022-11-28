import Combine
import CombineSchedulers
import Foundation
import Feature_MatchDetails_Repository

public struct MatchDetailsEnvironment {
    let service: MatchDetailsService
    let scheduler: AnySchedulerOf<DispatchQueue>

    public init(
        service: MatchDetailsService,
        scheduler: AnySchedulerOf<DispatchQueue>
    ) {
        self.service = service
        self.scheduler = scheduler
    }
}

#if DEBUG
public extension MatchDetailsEnvironment {
    static func fixture(
        service: MatchDetailsService = .failing,
        scheduler: AnySchedulerOf<DispatchQueue> = .immediate.eraseToAnyScheduler()
    ) -> Self {
        .init(
            service: service,
            scheduler: scheduler
        )
    }
}
#endif
