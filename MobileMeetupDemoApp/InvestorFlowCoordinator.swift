import ReactiveSwift

final class InvestorFlowCoordinator: BaseFlowCoordinator {

    override func start() {
        iapplicationManager.application.producer
        .skipRepeats()
        .startWithValues { [weak self] application in
            if let application = application {
                switch application.state {
                case .approved:
                    self?.presentDashboard()
                case .other:
                    self?.presentOnboarding()
                }
            } else {
                self?.presentAnonymous()
            }
        }
        
        // Just for presentation purpose. Emulate a network call from ViewModel
        DispatchQueue.main.async(execute: { [weak self] in
            self?.iapplicationManager.fetchApplication.apply().start()
        })
    }
    
    private func presentDashboard() {
        print("InvestorFlowCoordinator: presentDashboard")
    }
    
    private func presentOnboarding() {
        print("InvestorFlowCoordinator: presentOnboarding")
    }
    
    private func presentAnonymous() {
        print("InvestorFlowCoordinator: presentAnonymous")
    }
    
    let iapplicationManager: IApplicationManaging
    
    init(iapplicationManager: IApplicationManaging) {
        self.iapplicationManager = iapplicationManager
    }
}
