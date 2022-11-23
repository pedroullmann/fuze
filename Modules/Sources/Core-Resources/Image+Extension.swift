import SwiftUI

public extension Image {
    init(_ asset: ImageAsset) {
        self = asset.swiftUIImage
    }
}
