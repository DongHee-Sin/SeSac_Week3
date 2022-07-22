//
//  SceneDelegate.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 여기있으면 안되는 코드
        //UserDefaults.standard.set(false, forKey: "First")  // ture이면 VC를 띄우고, false이면 SearchMovieVC를 띄우기
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        if UserDefaults.standard.bool(forKey: "First") {
            // root VC 생성
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "TestViewController") as? TestViewController else {
                return
            }
            window?.rootViewController = vc
        }else {
            // root VC 생성
            let sb = UIStoryboard(name: "Search", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController else {
                return
            }
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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

