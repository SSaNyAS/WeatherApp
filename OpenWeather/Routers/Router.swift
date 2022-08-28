//
//  Router.swift
//  OpenWeather
//
//  Created by Алексей Рябин on 25.08.2022.
//

import Foundation
import UIKit
protocol RouterDelegate{
    func goToViewController(from viewController: UIViewController, to viewControllerType: RoutedViewController, presentationMode: ViewControllerPresentMode)
    func setRootViewController(for window: UIWindow?,viewController: RoutedViewController)
}
class Router: RouterDelegate{
    
    func setRootViewController(for window: UIWindow?, viewController: RoutedViewController) {
        window?.rootViewController = viewController.getViewController
        window?.makeKeyAndVisible()
    }
    
    func goToViewController(from viewController: UIViewController, to viewControllerType: RoutedViewController, presentationMode: ViewControllerPresentMode) {
        let showingVC = viewControllerType.getViewController
        presentWithMode(from: viewController, to: showingVC, presentMode: presentationMode)
    }
    
    private func presentWithMode(from viewController: UIViewController, to presentedViewController: UIViewController, presentMode: ViewControllerPresentMode){
        switch presentMode {
        case .present:
            viewController.present(presentedViewController, animated: true)
        case .push:
            viewController.navigationController?.pushViewController(presentedViewController, animated: true)
        case .modal:
            viewController.present(presentedViewController, animated: true)
        case .custom(let modalPresentationStyle, let modalTransitionStyle):
            presentedViewController.modalPresentationStyle = modalPresentationStyle
            presentedViewController.modalTransitionStyle = modalTransitionStyle
            viewController.present(presentedViewController, animated: true)
        }
    }
    
    init(){
        
    }
}
