//
//  SceneDelegate.swift
//  Mast
//
//  Created by Shihab Mehboob on 11/09/2019.
//  Copyright © 2019 Shihab Mehboob. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch (deviceIdiom) {
        case .pad:
            let rootController = ColumnViewController()
            let nav0 = UINavigationController(rootViewController: VerticalTabBarController())
            let nav1 = ScrollMainViewController()

            let nav01 = UINavigationController(rootViewController: FirstViewController())
            let nav02 = UINavigationController(rootViewController: SecondViewController())
            let nav03 = UINavigationController(rootViewController: ThirdViewController())
            let nav04 = UINavigationController(rootViewController: FourthViewController())
            let nav05 = UINavigationController(rootViewController: FifthViewController())
            nav1.viewControllers = [nav01, nav02, nav03, nav04, nav05]

            rootController.viewControllers = [nav0, nav1]
            self.window?.rootViewController = rootController
            self.window!.makeKeyAndVisible()
        default:
            print("nil")
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = (URLContexts.first?.url ?? URL(string: "www.google.com")) {
            if url.host == "success" {
                print("Response ==> \(url.absoluteString)")
                let x = url.absoluteString
                let y = x.split(separator: "=")
                GlobalStruct.authCode = y.last?.description ?? ""
                NotificationCenter.default.post(name: Notification.Name(rawValue: "logged"), object: nil)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        self.window?.tintColor = GlobalStruct.baseTint
        NotificationCenter.default.post(name: Notification.Name(rawValue: "startHaptics"), object: self)
        
//        do {
//            StoreStruct.currentUser = try Disk.retrieve("\(StoreStruct.currentInstance.clientID)use.json", from: .documents, as: Account.self)
//            StoreStruct.statusesHome = try Disk.retrieve("\(StoreStruct.currentInstance.clientID)home.json", from: .documents, as: [Status].self)
//            StoreStruct.statusesLocal = try Disk.retrieve("\(StoreStruct.currentInstance.clientID)local.json", from: .documents, as: [Status].self)
//            StoreStruct.statusesFederated = try Disk.retrieve("\(StoreStruct.currentInstance.clientID)fed.json", from: .documents, as: [Status].self)
//        } catch {
//            print("Couldn't load")
//        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

