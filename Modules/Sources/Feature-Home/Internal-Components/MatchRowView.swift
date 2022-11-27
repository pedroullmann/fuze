import Core_DesignSystem
import Core_UI
import Feature_Home_Repository
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
                versusView
                Spacer()
                Divider().background(.dividerPrimary)
                bottomView
            }
        }
        .frame(height: DS.Components.matchCard.height)
        .frame(maxWidth: DS.Components.matchCard.width)
    }

    private var versusView: some View {
        HStack(spacing: DS.Spacing.m) {
            match.opponents.first.map(opponentView)

            Text("vs")
                .textToken(.init(.paragraph2, .textSecondary))

            match.opponents.last.map(opponentView)
        }
    }

    private var bottomView: some View {
        HStack(spacing: .zero) {
            ImageView(urlString: match.league.imageUrl ?? "", size: .small)
                .clipShape(Circle())
                .padding(.leading, DS.Spacing.s)

            Text("\(match.league.name) | \(match.serie)")
                .textToken(.init(.paragraph4, .textPrimary))
                .padding(.leading, DS.Spacing.xxs)

            Spacer()
        }
        .padding(.vertical, DS.Spacing.xxs)
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
                .frame(maxWidth:  60)
                .multilineTextAlignment(.center)
        }
    }
}

#if DEBUG
struct MatchRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            previewMatchNow
            previewMatchThisWeek
            previewMatchNextWeek
        }
    }

    static var previewMatchNow: some View {
        MatchRowView(
            match: .fixture(
                beginAt: "2022-11-25T18:00:00Z",
                opponents: MatchModel.Opponent.elements,
                status: .running
            )
        )
    }

    static var previewMatchThisWeek: some View {
        MatchRowView(
            match: .fixture(
                beginAt: "2022-11-26T18:00:00Z",
                opponents: MatchModel.Opponent.elements,
                status: .notStarted
            )
        )
    }

    static var previewMatchNextWeek: some View {
        MatchRowView(
            match: .fixture(
                beginAt: "2022-11-31T18:00:00Z",
                opponents: MatchModel.Opponent.elements,
                status: .notStarted
            )
        )
    }
}
#endif
