//
//  AlertManager.swift
//  RedditTopFeed
//
//  Created by  Volodymyr Sakhan on 24.11.2020.
//

import Foundation

import UIKit

final class AlertManager: UIAlertController {
        
    class func alert(message: String, action: ((UIAlertAction) -> Void)? = nil, viewController: UIViewController? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: action)
        alert.addAction(action)
        
        present(on: viewController, with: alert)
    }
    
    class func present(on viewController: UIViewController?, with alert: UIAlertController, completion: (() -> Void)? = nil) {
        var actualViewController: UIViewController?
        
        if viewController == nil {
            var rootVC: UIViewController? = UIApplication.shared.windows.first?.rootViewController
            
            while let presentedViewController = rootVC?.presentedViewController {
                rootVC = presentedViewController
            }
            
            actualViewController = rootVC
        } else {
            actualViewController = viewController
        }
        
        DispatchQueue.main.async {
            actualViewController?.present(alert, animated: true, completion: completion)
        }
    }
    
}
