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
                .padding(.top, DS.Spacing.xm)

                Spacer()
            }
            .navigationTitle(match.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func playersRow(leading: Bool) -> some View {
        VStack(spacing: .zero) {
            Rectangle()
                .foregroundColor(.backgroundSecondary)
                .cornerRadius(
                    DS.BorderRadius.small,
                    corners: leading ? [.topRight, .bottomRight]: [.topLeft, .bottomLeft]
                )
                .frame(height: 54)
                .overlay (
                    HStack(spacing: .zero) {
                        if leading { Spacer() }
                        if leading { playerNameView(leading: leading) }

                        RoundedRectangle(cornerRadius: DS.BorderRadius.xSmall)
                            .foregroundColor(.placeholder)
                            .frame(width: DS.Components.playerImage.width)
                            .frame(height: DS.Components.playerImage.height)
                            .padding(leading ? .trailing: .leading, DS.Spacing.xxs)
                            .offset(y: -DS.Spacing.xxs)

                        if !leading { playerNameView(leading: leading) }
                        if !leading { Spacer() }
                    }
                )
        }
        .edgesIgnoringSafeArea(.leading)
    }

    private func playerNameView(leading: Bool) -> some View {
        VStack(alignment: leading ? .trailing: .leading, spacing: .zero) {
            Text("Nickname")
                .textToken(.init(.paragraph1Bold, .textPrimary))

            Text("Nome Jogador")
                .textToken(.init(.paragraph2, .textSecondary))
        }
        .padding(leading ? .trailing: .leading, DS.Spacing.xs)
    }
}
