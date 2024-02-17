import UIKit
import DiStorage

final class RootRouter {
    weak var window: UIWindow!

    init(window: UIWindow) {
        self.window = window
        // Installing dependencies for unauth zone of application
        Self.installUnauthZoneDependencies()
    }
}

// MARK: - Public

extension RootRouter {
    func initialVC() -> UIViewController {
        let vc = createInitialVC()
        return UINavigationController(rootViewController: vc)
    }
}

// MARK: - Install dependencies

extension RootRouter {
    // Installing dependencies for unauth zone of application
   static private func installUnauthZoneDependencies() {
       UnauthDiScope().bind(di: DiStorage.shared)
    }

    // Installing dependencies for auth zone of application
    static private func installAuthZoneDependencies() {
        AuthDiScope().bind(di: DiStorage.shared)
    }

    // Dropping dependencies for unauth zone of application
    static private func dropAuthZoneDependencies() {
        DiStorage.shared.remove(scope: AuthDiScope.self)
    }
}

// MARK: - Private, Creating ViewControllers

extension RootRouter {
    private func createInitialVC() -> UIViewController {
        let authStatusProviderUsecase: AuthStatusProviderUsecase = DiStorage.shared.resolve()

        let authStatus = authStatusProviderUsecase.execute()

        switch authStatus {
            case .unauthorized:
                return createUnauthZoneInitialVC()
            case .authorized:
                return createAuthZoneInitialVC()
        }
    }
    private func createUnauthZoneInitialVC() -> UIViewController {
        // Dropping dependencies for unauth zone of application
        Self.dropAuthZoneDependencies()

        let checkDropped =
        DiStorage.shared.tryResolve(DoSomethingRepository.self) == nil &&
        DiStorage.shared.tryResolve(LogoutUsecase.self) == nil &&
        DiStorage.shared.tryResolve(DoSomethingUsecase.self) == nil
        
        assert(checkDropped)

        let vc = LoginVC(authUsecase: DiStorage.shared.resolve())

        vc.onRoute = {
            switch $0 {
                case .onAuth(let sender):
                    self.onPerformeToZoneTransistion(sender)
            }
        }

        return vc
    }

    private func createAuthZoneInitialVC() -> UIViewController {
        // Installing dependencies for auth zone of application
        Self.installAuthZoneDependencies()

        let vc = HomeVC(
            doSomethingUsecase: DiStorage.shared.resolve(),
            logoutUsecase: DiStorage.shared.resolve()
        )

        vc.onRoute = {
            switch $0 {
                case .onLogout(let sender):
                    self.onPerformeToZoneTransistion(sender)
            }
        }

        return vc
    }
}

// MARK: - Private, ViewControllers Transistions

extension RootRouter {

    private func onPerformeToZoneTransistion(_ sender: UIViewController) {
        let authStatusProviderUsecase: AuthStatusProviderUsecase = DiStorage.shared.resolve()

        let authStatus = authStatusProviderUsecase.execute()

        switch authStatus {
            case .unauthorized:
                onUnauthZone(sender)
            case .authorized:
                onAuthZone(sender)
        }
    }


    private func onAuthZone(_ sender: UIViewController) {
        let vc = createAuthZoneInitialVC()
        let nc = UINavigationController(rootViewController: vc)
        transitionProcess(vc: nc)
    }

    private func onUnauthZone(_ sender: UIViewController) {
        let vc = createUnauthZoneInitialVC()
        let nc = UINavigationController(rootViewController: vc)
        transitionProcess(vc: nc)
    }
}

// MARK: - Transition

extension RootRouter {
    static let transitionDuration: TimeInterval = 0.35

    private func transitionProcess(vc: UIViewController) {
        window.rootViewController = vc
        UIView.transition(
            with: window,
            duration: Self.transitionDuration,
            options: [.transitionCrossDissolve, .allowAnimatedContent, .layoutSubviews],
            animations: nil,
            completion: nil
        )
    }
}
