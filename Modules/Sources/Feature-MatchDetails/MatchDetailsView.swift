import Core_DesignSystem
import Core_UI
import Feature_Home_Repository
import Root_Elements
import SwiftUI

public struct MatchDetailsView: View {
    private let match: MatchModel
    private let formatter: UTCDateFormatterProtocol

    public init(
        match: MatchModel,
        formatter: UTCDateFormatterProtocol = UTCDateFormatter()
    ) {
        self.match = match
        self.formatter = formatter
    }

    public var body: some View {
        FullScreenColor(.backgroundPrimary) {
            VStack(spacing: .zero) {
                VersusView(
                    model: .init(
                        team: .init(
                            image: match.opponents.first?.imageUrl,
                            name: match.opponents.first?.name
                        ),
                        rival: .init(
                            image: match.opponents.last?.imageUrl,
                            name: match.opponents.last?.name
                        )
                    )
                )
                .padding(.top, DS.Spacing.m)

                formatter.toLocal(match.scheduledAt).map {
                    Text($0)
                        .textToken(.init(.paragraph2Bold, .textPrimary))
                }
                .padding(.top, DS.Spacing.m)

//                FullScreenLoadingTemplate(
//                    dataState: dataState,
//                    modelView: { _ in Text("Loaded") },
//                    refreshData: {}
//                )
//                .padding(.top, DS.Spacing.xm)

                Spacer()
            }
            .navigationTitle(match.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
