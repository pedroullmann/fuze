import Core_Resources
import SwiftUI

public struct PrimaryText: View {
    private let localized: LocalizedString

    public init(_ localized: LocalizedString) {
        self.localized = localized
    }

    public var body: some View {
        Text(localized.key, bundle: Resources.bundle)
    }
}
