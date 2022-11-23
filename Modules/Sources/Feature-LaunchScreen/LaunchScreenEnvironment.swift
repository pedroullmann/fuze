import Core_Resources
import Foundation
import Root_Elements

public struct LaunchScreenEnvironment {
    let resourcesBuilder: () -> Registarable
    let dispatchQueue: DispatchQueueType

    public init(
        resourcesBuilder: @escaping () -> Registarable = { Resources() },
        dispatchQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.resourcesBuilder = resourcesBuilder
        self.dispatchQueue = dispatchQueue
    }
}

#if DEBUG
public extension LaunchScreenEnvironment {
    static func fixture(
        resourcesBuilder: @escaping () -> Registarable = { ResourcesDummy() },
        dispatchQueue: DispatchQueueType = DispatchQueueImmediate()
    ) -> Self {
        .init(
            resourcesBuilder: resourcesBuilder,
            dispatchQueue: dispatchQueue
        )
    }
}
#endif
