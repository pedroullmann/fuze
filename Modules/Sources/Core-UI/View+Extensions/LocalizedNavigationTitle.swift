import Core_Resources
import SwiftUI

public extension View {
    func localizedNavigationTitle(_ localized: LocalizedString) -> some View {
        self.navigationTitle(Text(localized.key, bundle: Resources.bundle))
    }
}
