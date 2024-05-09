//
//  SceneDelegate.swift
//  AdWhaleSample-Swift
//
//  Created by FSN on 3/28/24.
//

import UIKit
import AdWhaleSDK

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var isAppOpenShowing = false


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
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
        
        // 앱 전환이 발생한 경우에도 app open 광고를 표시하고자 하는 경우 사용
        if (isAppOpenShowing) {
            isAppOpenShowing = false
            AdWhaleAppOpenAd.shared.adUnitId = "ca-app-pub-8713069554470817/7173349835"
            
            guard let windowScene = scene as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            if let topViewController = topViewController(of: rootViewController) {
                // topViewController를 기반으로 최상위 ViewController를 확인
                if topViewController is ViewController {
                    // ViewController인 경우에만 광고 표시
                    AdWhaleAppOpenAd.shared.showAdIfAvailable()
                }
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        isAppOpenShowing = true
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // UIWindow의 rootViewController부터 시작하여 최상위 ViewController를 찾는 함수
    private func topViewController(of viewController: UIViewController) -> UIViewController? {
       if let presentedViewController = viewController.presentedViewController {
           // 현재 ViewController가 다른 ViewController를 present한 경우
           return topViewController(of: presentedViewController)
       }
       if let navigationController = viewController as? UINavigationController {
           // 현재 ViewController가 UINavigationController일 경우
           return topViewController(of: navigationController.visibleViewController ?? navigationController)
       }
       if let tabBarController = viewController as? UITabBarController {
           // 현재 ViewController가 UITabBarController일 경우
           return topViewController(of: tabBarController.selectedViewController ?? tabBarController)
       }
       return viewController
    }
}
