import ReactiveSwift

class RootFlowCoordinator: BaseFlowCoordinator {
        
    override func start() {
        userManager.user.producer
            .skipRepeats()
            .startWithValues { [weak self] user in
                if let user = user {
                    switch user.role {
                    case .investor, .approvedInvestor:
                        self?.startInvestor()
                    }
                } else {
                    self?.startAnonymous()
                }
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
