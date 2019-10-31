import ReactiveSwift

struct IApplication {
    enum State {
        case approved
        case other
    }

    var state: State
}

extension IApplication: Comparable {
    static func < (lhs: IApplication, rhs: IApplication) -> Bool {
        return lhs.state.hashValue < rhs.state.hashValue
    }
}


protocol IApplicationManaging {
    var application: Property<IApplication?> { get }
    var fetchApplication: Action<Void, IApplication?, Never> { get }
}

final class IApplicationManager: IApplicationManaging {
    
    lazy var application = Property<IApplication?>(initial: nil, then: iApplicationSignal())

    lazy var fetchApplication = Action<Void, IApplication?, Never> { _ in
        return SignalProducer(value: IApplication(state: .approved))
    }
    
    let userManager: UserManaging
    
    init(userManager: UserManaging) {
        self.userManager = userManager
    }
    
    private func iApplicationSignal() -> Signal<IApplication?, Never> {
        return Signal.merge(
            fetchApplication.values.map { $0 },
            userManager.logout.completed.map { nil }
        )
    }
}
