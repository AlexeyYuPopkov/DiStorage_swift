//
//  HomeVC.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import MBProgressHUD

final class HomeVC: UIViewController, OnRouteProtocol {
    var onRoute: ((Route) -> Void)?
    let doSomethingUsecase: DoSomethingUsecase
    let logoutUsecase: LogoutUsecase

    let label = UILabel(frame: .zero)
    let doSomethingButton = UIButton(type: .custom)
    let logoutButton = UIButton(type: .custom)

    init(doSomethingUsecase: DoSomethingUsecase, logoutUsecase: LogoutUsecase) {
        self.doSomethingUsecase = doSomethingUsecase
        self.logoutUsecase = logoutUsecase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAccessibilityIdentifiers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        label.numberOfLines = 0
        label.text = """
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        In sed semper quam. Pellentesque quis facilisis erat.
                        Praesent tempor eros lorem, in luctus dolor facilisis id.
                    """

        let labelSize = label.systemLayoutSizeFitting(
            .init(width: view.bounds.width - 32.0,
                  height: view.bounds.height
                 ), withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        label.frame = .init(
            x: 16.0,
            y: view.bounds.height / 3.0,
            width: max(.zero, view.bounds.width - 32.0),
            height: labelSize.height
        )

        let doSomethingButtonSize = doSomethingButton.systemLayoutSizeFitting(
            .init(
                width: max(.zero, view.bounds.width - 32.0),
                height: 44.0
            ),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )

        doSomethingButton.frame = .init(
            x: max(16.0, (view.bounds.width - doSomethingButtonSize.width) / 2.0),
            y: label.frame.maxY + 16.0,
            width: doSomethingButtonSize.width,
            height: 32.0
        )


        let logoutButtonSize = logoutButton.systemLayoutSizeFitting(
            .init(
                width: max(.zero, view.bounds.width - 32.0),
                height: 44.0
            ),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )

        logoutButton.frame = .init(
            x: max(16.0, (view.bounds.width - logoutButtonSize.width) / 2.0),
            y: doSomethingButton.frame.maxY + 16.0,
            width: logoutButtonSize.width,
            height: 32.0
        )
    }
}

// MARK: - Setup

extension HomeVC {
    private func setup() {
        view.backgroundColor = .white

        label.textAlignment = .center
        view.addSubview(label)

        doSomethingButton.setTitle("Do Something", for: .normal)
        doSomethingButton.setTitleColor(.systemGreen, for: .normal)
        doSomethingButton.setTitleColor(.gray, for: .selected)
        doSomethingButton.setTitleColor(.gray, for: .highlighted)
        doSomethingButton.setTitleColor(.gray, for: .disabled)
        doSomethingButton.titleLabel?.textAlignment = .center
        doSomethingButton.addTarget(self, action: #selector(doSomethingButtonAction), for: .touchUpInside)
        view.addSubview(doSomethingButton)

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.systemGreen, for: .normal)
        logoutButton.setTitleColor(.gray, for: .selected)
        logoutButton.setTitleColor(.gray, for: .highlighted)
        logoutButton.setTitleColor(.gray, for: .disabled)
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    private func setupAccessibilityIdentifiers() {
        view.accessibilityIdentifier = "HomeVC.AccessibilityId"
        label.accessibilityIdentifier = "Label.AccessibilityId"
        doSomethingButton.accessibilityIdentifier = "DoSomethingButton.AccessibilityId"
        logoutButton.accessibilityIdentifier = "SendButton.AccessibilityId"
    }
}

// MARK: - Actions

extension HomeVC {
    @objc func doSomethingButtonAction(_ sender: UIButton) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.accessibilityIdentifier = "LoadingIndicator"
        
        doSomethingUsecase.execute {
            switch $0 {
                case .success:
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                case .failure:
                    // Handle error
                    break
            }
        }
    }

    @objc func logoutButtonAction(_ sender: UIButton) {
        logoutUsecase.execute()
        onRoute?(.onLogout(self))
    }
}

// MARK: - Routing

extension HomeVC {
    enum Route {
        case onLogout(_ sender: UIViewController)
    }
}
