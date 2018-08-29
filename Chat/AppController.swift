//
//  AppController.swift
//  Chat
//
//  Created by NikitaPrakash Patil on 8/24/18.
//  Copyright © 2018 NikitaPrakash Patil. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

final class AppController {
    
    static let shared = AppController()
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userStateDidChange),
            name: Notification.Name.AuthStateDidChange,
            object: nil
        )
    }
    
    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            if let vc = rootViewController {
                window.rootViewController = vc
            }
        }
    }
    
    // MARK: - Helpers
    
    func show(in window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot layout app with a nil window.")
        }
        
        FirebaseApp.configure()
        
        self.window = window
        window.tintColor = .primary
        window.backgroundColor = .white
        
        handleAppState()
        
        window.makeKeyAndVisible()
    }
    
    private func handleAppState() {
        if let user = Auth.auth().currentUser {
            let vc = ProfileViewController(currentUser: user)
            rootViewController = NavigationController(vc)
        } else {
            rootViewController = LoginViewController()
        }
    }
    
    // MARK: - Notifications
    
    @objc internal func userStateDidChange() {
        DispatchQueue.main.async {
            self.handleAppState()
        }
    }
    
}
