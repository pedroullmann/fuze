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

#if DEBUG
struct PrimaryText_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryText(.errorSubtitle)
            .environment(\.locale, .init(identifier: "en"))

        PrimaryText(.errorSubtitle)
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
#endif
