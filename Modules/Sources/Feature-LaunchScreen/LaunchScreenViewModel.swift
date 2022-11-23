import Combine
import Core_Resources
import SwiftUI

public final class LaunchScreenViewModel: ObservableObject {
    public init(
        resources: Registarable = Resources()
    ) {
        resources.registerFonts(
            fonts: Font.MontserratStyle.allCases,
            failureHandler: { error in
                // TODO: Logger
                print(error)
            }
        )
    }
}
