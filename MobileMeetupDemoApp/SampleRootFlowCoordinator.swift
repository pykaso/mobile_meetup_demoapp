import ReactiveSwift

class SampleRootFlowCoordinator: BaseFlowCoordinator {
    
    override func start() {
        guard let user = userManager.user.value else {
            startAnonymous()
            return
        }

        switch user.role {
        case .investor, .approvedInvestor:
            startInvestor()
        }
    }

    private func startInvestor() {
        print("RootFlowCoordinator: startInvestor")
        let fc = InvestorFlowCoordinator(iapplicationManager: iapplicationManager)
        addChild(fc)
        fc.start()
    }

    private func startAnonymous() {
        print("RootFlowCoordinator: startAnonymous")
    }

    let userManager: UserManaging
    let iapplicationManager: IApplicationManaging

    init(userManager: UserManaging, iapplicationManager: IApplicationManaging) {
        self.userManager = userManager
        self.iapplicationManager = iapplicationManager
        super.init()
        start()
    }
}
