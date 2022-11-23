import Foundation

public struct LaunchScreenState: Equatable {
    public enum Route: Equatable {
        case splash
        case home
    }

    var route: Route

    public init(initialRoute: Route = .splash) {
        self.route = initialRoute
    }
}
