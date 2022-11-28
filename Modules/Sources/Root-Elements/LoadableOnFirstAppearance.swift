import Combine

public protocol LoadableOnFirstAppearance: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
    var onAppear: PassthroughSubject<Void, Never> { get }
    func fetch()
}

public extension LoadableOnFirstAppearance {
    func loadingOnFirstAppearance() {
        onAppear
            .first()
            .sink { [weak self] _ in self?.fetch() }
            .store(in: &cancellables)
    }
}
