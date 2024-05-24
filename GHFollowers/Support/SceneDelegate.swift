//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // First func will run in a scene same as [didFinishLaunchingWithOptions] in AppDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Setup window
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // Setup root viewController
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        configureNC()
        
    }

    private func createSearchVC() -> UINavigationController {
        let SearchVC = SearchVC()
        SearchVC.title = "Search"
        SearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        return UINavigationController(rootViewController: SearchVC)
    }
    
    private func createFavoritesVC() -> UINavigationController {
        let favoriteVC = FavoritesVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        
        UITabBar.appearance().tintColor = .systemGreen
        
        let blur = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.tabBar.addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.bottomAnchor.constraint(equalTo: tabBar.tabBar.bottomAnchor),
            blurView.topAnchor.constraint(equalTo: tabBar.tabBar.topAnchor),
            blurView.trailingAnchor.constraint(equalTo: tabBar.tabBar.trailingAnchor),
            blurView.leadingAnchor.constraint(equalTo: tabBar.tabBar.leadingAnchor),
        ])
        
        

        
        tabBar.viewControllers = [createSearchVC(), createFavoritesVC()]
        return tabBar
    }
    
    private func configureNC() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
     
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
     
    }

    func sceneWillResignActive(_ scene: UIScene) {
     
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
     
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
     
    }


}

