import Core_Resources
import Feature_Home_Repository
import Foundation
import Root_Elements

public struct LaunchScreenEnvironment {
    let resourcesBuilder: () -> Registarable
    let dispatchQueue: DispatchQueueType
    let homeService: HomeService

    public init(
        resourcesBuilder: @escaping () -> Registarable = { Resources() },
        dispatchQueue: DispatchQueueType = DispatchQueue.main,
        homeService: HomeService
    ) {
        self.resourcesBuilder = resourcesBuilder
        self.dispatchQueue = dispatchQueue
        self.homeService = homeService
    }
}

#if DEBUG
public extension LaunchScreenEnvironment {
    static func fixture(
        resourcesBuilder: @escaping () -> Registarable = { ResourcesDummy() },
        dispatchQueue: DispatchQueueType = DispatchQueueImmediate(),
        homeService: HomeService = .failing
    ) -> Self {
        .init(
            resourcesBuilder: resourcesBuilder,
            dispatchQueue: dispatchQueue,
            homeService: homeService
        )
    }
}
#endif
