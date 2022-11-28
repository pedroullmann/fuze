import Core_DesignSystem
import Core_UI
import Feature_Home_Repository
import Root_Elements
import SwiftUI

struct MatchRowView: View {
    private let match: MatchModel
    private let formatter: UTCDateFormatterProtocol

    init(
        match: MatchModel,
        formatter: UTCDateFormatterProtocol = UTCDateFormatter()
    ) {
        self.match = match
        self.formatter = formatter
    }

    var body: some View {
        ZStack {
            backgroundView

            VStack(spacing: .zero) {
                Spacer()
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
                Spacer()
                Divider().background(.dividerPrimary)
                bottomView
            }
        }
        .frame(height: DS.Components.matchCard.height)
        .frame(maxWidth: DS.Components.matchCard.width)
    }

    private var bottomView: some View {
        HStack(spacing: .zero) {
            ImageView(urlString: match.league.imageUrl ?? "", size: .small)
                .clipShape(Circle())
                .padding(.leading, DS.Spacing.s)

            Text(match.title)
                .textToken(.init(.paragraph4, .textPrimary))
                .padding(.leading, DS.Spacing.xxs)

            Spacer()
        }
        .padding(.vertical, DS.Spacing.xxs)
    }

    private var backgroundView: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(
                cornerRadius: DS.BorderRadius.medium,
                style: .continuous
            )
            .foregroundColor(.backgroundSecondary)

            statusView
        }
    }

    @ViewBuilder
    private var statusView: some View {
        Group {
            if match.status.isRunning {
                PrimaryText(.now)
                    .textCase(.uppercase)
            } else {
                formatter.toLocal(match.scheduledAt).map(Text.init)
            }
        }
        .textToken(.init(.paragraph4Bold, .textPrimary))
        .padding(DS.Spacing.xxs)
        .background(
            Color(match.status.isRunning ? .staticRed: .elementOverSecondary)
                .cornerRadius(DS.BorderRadius.medium, corners: [.topRight, .bottomLeft])
        )
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
                scheduledAt: "2022-11-25T18:00:00Z",
                opponents: MatchModel.Opponent.elements,
                status: .running
            )
        )
    }

    static var previewMatchThisWeek: some View {
        MatchRowView(
            match: .fixture(
                scheduledAt: "2022-11-26T18:00:00Z",
                opponents: MatchModel.Opponent.elements,
                status: .notStarted
            )
        )
    }

    static var previewMatchNextWeek: some View {
        MatchRowView(
            match: .fixture(
                scheduledAt: "2022-11-31T18:00:00Z",
                opponents: MatchModel.Opponent.elements,
                status: .notStarted
            )
        )
    }
}
#endif
