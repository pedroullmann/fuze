import Core_DesignSystem
import SwiftUI

public struct ImageView: View {
    private let url: URL?
    private let size: Size

    public init(
        urlString: String,
        size: Size
    ) {
        self.url = .init(string: urlString)
        self.size = size
    }

    public var body: some View {
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                Circle()
                    .foregroundColor(.placeholder)
            }
        )
        .frame(
            width: size.width,
            height: size.height
        )
    }
}

public extension ImageView {
    struct Size {
        let height: CGFloat
        let width: CGFloat

        private init(
            height: CGFloat,
            width: CGFloat
        ) {
            self.height = height
            self.width = width
        }
    }
}

public extension ImageView.Size {
    static let regular: Self = .init(height: 60, width: 60)
    static let small: Self = .init(height: 16, width: 16)
}
