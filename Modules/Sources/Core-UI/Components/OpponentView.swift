import Core_DesignSystem
import SwiftUI

public extension VersusView {
    struct Model {
        let team: Team
        let rival: Team

        public init(
            team: Team,
            rival: Team
        ) {
            self.team = team
            self.rival = rival
        }

        public struct Team {
            let image: String?
            let name: String?

            public init(
                image: String?,
                name: String?
            ) {
                self.image = image
                self.name = name
            }
        }
    }
}

public struct VersusView: View {
    private let model: Model

    public init(model: Model) {
        self.model = model
    }

    public var body: some View {
        HStack(spacing: DS.Spacing.m) {
            teamView(model.team)
            Text("vs").textToken(.init(.paragraph2, .textSecondary))
            teamView(model.rival)
        }
    }

    private func teamView(_ team: Model.Team) -> some View {
        VStack(spacing: DS.Spacing.xs) {
            ImageView(urlString: team.image ?? "", size: .regular)

            team.name.map {
                Text($0)
                    .textToken(.init(.paragraph3, .textPrimary))
                    .frame(maxWidth:  60)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
