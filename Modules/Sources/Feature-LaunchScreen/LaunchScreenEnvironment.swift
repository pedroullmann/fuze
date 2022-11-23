import Core_Resources
import Foundation

public struct LaunchScreenEnvironment {
    let resourcesBuilder: () -> Registarable

    public init(
        resourcesBuilder: @escaping () -> Registarable = { Resources() }
    ) {
        self.resourcesBuilder = resourcesBuilder
    }
}

#if DEBUG
public extension LaunchScreenEnvironment {
    static func fixture(
        resourcesBuilder: @escaping () -> Registarable = { ResourcesDummy() }
    ) -> Self {
        .init(resourcesBuilder: resourcesBuilder)
    }
}
#endif
