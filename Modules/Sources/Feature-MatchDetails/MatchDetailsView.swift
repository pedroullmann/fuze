import Core_DesignSystem
import Core_UI
import Feature_Home_Repository
import Feature_MatchDetails_Repository
import Root_Elements
import SwiftUI

public struct MatchDetailsView: View {
    @ObservedObject private var viewModel: MatchDetailsViewModel
    private let match: MatchModel
    private let formatter: UTCDateFormatterProtocol

    public init(
        match: MatchModel,
        formatter: UTCDateFormatterProtocol = UTCDateFormatter(),
        viewModel: MatchDetailsViewModel
    ) {
        self.match = match
        self.formatter = formatter
        self.viewModel = viewModel
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

                FullScreenLoadingTemplate(
                    dataState: viewModel.state.dataState,
                    modelView: playersView,
                    refreshData: { viewModel.fetch(match) }
                )
                .padding(.top, DS.Spacing.xm)

                Spacer()
            }
            .navigationTitle(match.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear { viewModel.fetch(match) }
    }

    private func playersView(_ players: MatchDetailsState.Players) -> some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top,spacing: DS.Spacing.xxs) {
                VStack(spacing: DS.Spacing.s) {
                    ForEach(players.team) { player in
                        leadingRow(player)
                    }
                }

                VStack(spacing: DS.Spacing.s) {
                    ForEach(players.rival) { player in
                        trailingRow(player)
                    }
                }
            }
            .edgesIgnoringSafeArea(.horizontal)
            .offset(y: DS.Spacing.xxs)
        }
    }

    private func leadingRow(_ player: PlayerModel) -> some View {
        Rectangle()
            .foregroundColor(.backgroundSecondary)
            .cornerRadius(DS.BorderRadius.small, corners: [.topRight, .bottomRight])
            .frame(height: 54)
            .overlay (
                HStack(spacing: .zero) {
                    Spacer()

                    VStack(alignment: .trailing, spacing: .zero) {
                        Text(player.nickname)
                            .textToken(.init(.paragraph1Bold, .textPrimary))

                        player.firstName.map {
                            Text("\($0) \(player.lastName ?? "")")
                                .textToken(.init(.paragraph2, .textSecondary))
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .padding(.trailing, DS.Spacing.xs)

                    customAsyncImage(player.imageUrl)
                        .padding(.trailing, DS.Spacing.xxs)
                }
            )
    }

    private func trailingRow(_ player: PlayerModel) -> some View {
        Rectangle()
            .foregroundColor(.backgroundSecondary)
            .cornerRadius(DS.BorderRadius.small, corners: [.topLeft, .bottomLeft])
            .frame(height: 54)
            .overlay (
                HStack(spacing: .zero) {
                    customAsyncImage(player.imageUrl)
                        .padding(.leading, DS.Spacing.xxs)

                    VStack(alignment: .leading, spacing: .zero) {
                        Text(player.nickname)
                            .textToken(.init(.paragraph1Bold, .textPrimary))
                            .multilineTextAlignment(.leading)

                        player.firstName.map {
                            Text("\($0) \(player.lastName ?? "")")
                                .textToken(.init(.paragraph2, .textSecondary))
                        }
                    }
                    .padding(.leading, DS.Spacing.xs)

                    Spacer()
                }
            )
    }

    private func customAsyncImage(_ image: String?) -> some View {
        AsyncImage(
            url: .init(string: image ?? ""),
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                RoundedRectangle(cornerRadius: DS.BorderRadius.xSmall)
                    .foregroundColor(.placeholder)
            }
        )
        .frame(width: DS.Components.playerImage.width)
        .frame(height: DS.Components.playerImage.height)
        .offset(y: -DS.Spacing.xxs)
    }
}
