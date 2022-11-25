import Core_DesignSystem
import Core_UI
import Root_Elements
import SwiftUI

struct MatchRowView: View {
    private let match: MatchModel
    private let formatter: UTCDateFormatter

    init(
        match: MatchModel,
        formatter: UTCDateFormatter = .init()
    ) {
        self.match = match
        self.formatter = formatter
    }

    var body: some View {
        ZStack {
            backgroundView

            VStack(spacing: .zero) {
                Spacer()

                HStack(spacing: DS.Spacing.m) {
                    match.opponents.first.map(opponentView)

                    Text("vs")
                        .textToken(.init(.paragraph2, .textSecondary))

                    match.opponents.last.map(opponentView)
                }

                Spacer()

                Divider()
                    .background(.dividerPrimary)

                HStack(spacing: .zero) {
                    ImageView(urlString: match.league.imageUrl ?? "", size: .small)
                        .padding(.leading, DS.Spacing.s)

                    Text("\(match.league.name) | \(match.serie)")
                        .textToken(.init(.paragraph4, .textPrimary))
                        .padding(.leading, DS.Spacing.xxs)

                    Spacer()
                }
                .padding(.vertical, DS.Spacing.xxs)
            }
        }
        .frame(height: DS.Components.matchCard.height)
        .frame(maxWidth: DS.Components.matchCard.width)
    }

    private var backgroundView: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(
                cornerRadius: DS.BorderRadius.small,
                style: .continuous
            )
            .foregroundColor(.backgroundSecondary)

            match.beginAt.map(statusView)
        }
    }

    @ViewBuilder
    private func statusView(_ beginAt: String) -> some View {
        Group {
            if match.status.isRunning {
                PrimaryText(.now)
                    .textCase(.uppercase)
            } else {
                formatter.toLocal(beginAt).map(Text.init)
            }
        }
        .textToken(.init(.paragraph4Bold, .textPrimary))
        .padding(DS.Spacing.xxs)
        .background(
            Color(match.status.isRunning ? .staticRed: .elementOverSecondary)
                .cornerRadius(DS.BorderRadius.small, corners: [.topRight, .bottomLeft])
        )
    }

    private func opponentView(_ opponent: MatchModel.Opponent) -> some View {
        VStack(spacing: DS.Spacing.xs) {
            ImageView(urlString: opponent.imageUrl ?? "", size: .regular)

            Text(opponent.name)
                .textToken(.init(.paragraph3, .textPrimary))
        }
    }
}
