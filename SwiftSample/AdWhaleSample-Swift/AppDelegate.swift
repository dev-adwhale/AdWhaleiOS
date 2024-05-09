//
//  AppDelegate.swift
//  AdWhaleSample-Swift
//
//  Created by FSN on 3/28/24.
//

import UIKit
import AdWhaleSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var isAppLaunching = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // SDK Init
        AdWhaleAds.sharedInstance.initialize {
            // SDK 초기화 완료 후 동작 코드
            AdWhaleAppOpenAd.shared.appOpenAdDelegate = self
            self.isAppLaunching = true
            
            // 앱 실행 시에만 앱 오프닝 광고를 표시하고자 하는 경우 사용
            // applicationDidBecomeActive 에서 앱 전환 발생한 경우 코드를 사용하는 경우 작성 불필요
//            AdWhaleAppOpenAd.shared.adUnitId = "ca-app-pub-8713069554470817/7173349835"
//            AdWhaleAppOpenAd.shared.loadAd()
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


// MARK: AppOpenAd Delegate
extension AppDelegate: AdWhaleAppOpenAdDelegate {
    func adDidReceiveAppOpenAd(_ ad: AdWhaleAppOpenAd) {
        // 광고 로드가 완료되면 메소드가 실행됩니다.
        print("adDidReceiveAppOpenAd")
        
        // 앱 오픈 시 앱 오프닝 광고를 반드시 표시하고 싶은 경우 사용
        if (isAppLaunching) {
            isAppLaunching = false
            AdWhaleAppOpenAd.shared.showAdIfAvailable()
        }
    }
    
    func adDidFailToReceiveAppOpenAd(error: Error) {
        // 광고 로드가 실패하고 발생한 오류를 포함합니다.
        print("adDidFailToReceiveAppOpenAd error: \(error.localizedDescription)")
    }
    
    func adWillPresentAppOpenAd() {
        // 광고가 전체 화면 콘텐츠를 표시할 때 호출됩니다.
        print("adWillPresentAppOpenAd")
    }
    
    func adDidDismissAppOpenAd() {
        // 전체 화면 콘텐츠를 닫을 때 호출됩니다.
        print("adDidDismissAppOpenAd")
    }
    
    func adDidFailToPresentAppOpenAd(error: Error) {
        // 전체 화면 콘텐츠 표시가 실패하고 발생한 오류를 포합합니다.
        print("adDidFailToPresentAppOpenAd error: \(error)")
    }
}

