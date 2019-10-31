import ReactiveSwift

struct User {
    enum Role {
        case investor
        case approvedInvestor
    }

    var name: String
    var role: Role
}

extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.name < rhs.name && lhs.role.hashValue < rhs.role.hashValue
    }
}

protocol UserManaging {
    var user: Property<User?> { get }
    var login: Action<Void, User?, Never> { get }
    var fetchMe: Action<Void, User?, Never> { get }
    var logout: Action<Void, Void, Never> { get }
}

final class UserManager: UserManaging {
    
    lazy var user = Property(initial: nil, then: userSignal())

    lazy var login = Action<Void, User?, Never> { [unowned self] _ in
        return self.userAPI.login()
    }
    
    lazy var logout = Action<Void, Void, Never> { [unowned self] _ in
        return self.userAPI.logout()
    }

    lazy var fetchMe = Action<Void, User?, Never> { [unowned self] _ in
        return self.userAPI.fetchMe()
    }
    
    let userAPI: UserAPIServicing
    
    init(userAPI: UserAPIServicing) {
        self.userAPI = userAPI
    }
    
    private func userSignal() -> Signal<User?, Never> {
        return Signal.merge(
                   fetchMe.values.map { $0 },
                   login.values.map { $0 },
                   logout.completed.map { _ in nil })
    }
}
