import Dispatch

public protocol DispatchQueueType {
    func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    public func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) {
        let workItem = DispatchWorkItem(block: execute)
        asyncAfter(deadline: deadline, execute: workItem)
    }
}

#if DEBUG
public struct DispatchQueueImmediate: DispatchQueueType {
    public init() {}
    public func asyncAfter(deadline: DispatchTime, execute: @escaping () -> Void) {
        execute()
    }
}
#endif
