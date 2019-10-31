protocol FlowCoordinator {
    func start()
    func addChild(_ flowCoordinator: BaseFlowCoordinator)
    func childDidCompleted(_ flowCoordinator: BaseFlowCoordinator)
}

class BaseFlowCoordinator: FlowCoordinator {
    
    private var childCoordinators:[BaseFlowCoordinator] = []
    
    weak var parent: BaseFlowCoordinator?
    
    func start() {}
    
    func addChild(_ flowCoordinator: BaseFlowCoordinator) {
        flowCoordinator.parent = self
        childCoordinators.append(flowCoordinator)
    }
    
    func childDidCompleted(_ flowCoordinator: BaseFlowCoordinator) {
        removeChild(flowCoordinator)
    }
    
    private func removeChild(_ flowCoordinator: BaseFlowCoordinator) {
        if let index = childCoordinators.firstIndex (where: { $0 === flowCoordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
