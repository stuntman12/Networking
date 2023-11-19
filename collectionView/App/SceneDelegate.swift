//
//  SceneDelegate.swift
//  collectionView
//
//  Created by Даниил on 11.11.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//        let tabBarContr = UITabBarController()
        let firstNavigation = UINavigationController(rootViewController: MainViewController())
//        let secondNavigation = UINavigationController(rootViewController: PostViewController())
//        tabBarContr.viewControllers = [
//            firstNavigation,
//            secondNavigation
//        ]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = firstNavigation
        window?.makeKeyAndVisible()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
    }
}

