import ReactiveSwift

protocol UserAPIServicing {
    func login() -> SignalProducer<User?, Never>
    func fetchMe() -> SignalProducer<User?, Never>
    func logout() -> SignalProducer<Void, Never>
}

final class UserAPIService: UserAPIServicing {
    func login() -> SignalProducer<User?, Never> {
        return SignalProducer(value: User(name: "František Vomáčka", role: .investor))
    }

    func fetchMe() -> SignalProducer<User?, Never> {
        return SignalProducer(value: User(name: "František Vomáčkas", role: .approvedInvestor))
    }

    func logout() -> SignalProducer<Void, Never> {
        return SignalProducer(value: ())
    }
}
