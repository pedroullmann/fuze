import Core_DesignSystem
import Core_UI
import Feature_Home_Repository
import SwiftUI

public struct MatchDetailsView: View {
    private let match: MatchModel

    public init(match: MatchModel) {
        self.match = match
    }

    public var body: some View {
        FullScreenColor(.backgroundPrimary) {
            Text("Detail")
                .navigationTitle(match.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
