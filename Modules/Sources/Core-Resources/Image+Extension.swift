import SwiftUI

// MARK: - SwiftUI Image initializer
public extension Image {
    init(_ asset: ImageAsset) {
        self = asset.swiftUIImage
    }
}
