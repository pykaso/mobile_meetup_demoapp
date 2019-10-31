struct Dependencies {
    
    static var shared:Dependencies = Dependencies()
    
    lazy var userAPI: UserAPIServicing = UserAPIService()
    lazy var userManager: UserManaging = UserManager(userAPI: userAPI)
    lazy var iapplicationManager: IApplicationManaging = IApplicationManager(userManager: userManager)
}
