import Core_Resources
import Feature_Home_Repository
import Feature_MatchDetails_Repository
import Foundation
import Root_Elements

public struct LaunchScreenEnvironment {
    let resourcesBuilder: () -> Registarable
    let dispatchQueue: DispatchQueueType
    let homeService: HomeService
    let matchDetailsService: MatchDetailsService

    public init(
        resourcesBuilder: @escaping () -> Registarable = { Resources() },
        dispatchQueue: DispatchQueueType = DispatchQueue.main,
        homeService: HomeService,
        matchDetailsService: MatchDetailsService
    ) {
        self.resourcesBuilder = resourcesBuilder
        self.dispatchQueue = dispatchQueue
        self.homeService = homeService
        self.matchDetailsService = matchDetailsService
    }
}

#if DEBUG
public extension LaunchScreenEnvironment {
    static func fixture(
        resourcesBuilder: @escaping () -> Registarable = { ResourcesDummy() },
        dispatchQueue: DispatchQueueType = DispatchQueueImmediate(),
        homeService: HomeService = .failing,
        matchDetailsService: MatchDetailsService = .failing
    ) -> Self {
        .init(
            resourcesBuilder: resourcesBuilder,
            dispatchQueue: dispatchQueue,
            homeService: homeService,
            matchDetailsService: matchDetailsService
        )
    }
}
#endif
