//
//  SplashViewController.swift
//  AdWhaleSample-Swift
//
//  Created by FSN on 6/21/24.
//

import UIKit
import AdWhaleSDK

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AdWhaleAppOpenAd.shared.adUnitId = "ca-app-pub-3940256099942544/5575463023"
        AdWhaleAppOpenAd.shared.appOpenAdDelegate = self
    }
    
    // Main 화면으로 이동
    func startMainScreen() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController")
        present(mainViewController, animated: true) {
            self.dismiss(animated: false) {
                let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
                keyWindow?.rootViewController = mainViewController
            }
        }
    }
}

// MARK: AppOpenAd Delegate
extension SplashViewController: AdWhaleAppOpenAdDelegate {
    func adDidReceiveAppOpenAd(_ ad: AdWhaleAppOpenAd) {
        // 광고 로드가 완료되면 메소드가 실행됩니다.
        print("adDidReceiveAppOpenAd")
        
        // AppOpen 광고 표시
        AdWhaleAppOpenAd.shared.showAdIfAvailable(self)
    }
    
    func adDidFailToReceiveAppOpenAd(error: Error) {
        // 광고 로드가 실패하고 발생한 오류를 포함합니다.
        print("adDidFailToReceiveAppOpenAd sample error: \(error.localizedDescription)")
        startMainScreen()
    }
    
    func adWillPresentAppOpenAd() {
        // 광고가 전체 화면 콘텐츠를 표시할 때 호출됩니다.
        print("adWillPresentAppOpenAd")
    }
    
    func adDidDismissAppOpenAd() {
        // 전체 화면 콘텐츠를 닫을 때 호출됩니다.
        print("adDidDismissAppOpenAd")
        AdWhaleAppOpenAd.shared.loadAd()
        startMainScreen()
    }
    
    func adDidFailToPresentAppOpenAd(error: Error) {
        // 전체 화면 콘텐츠 표시가 실패하고 발생한 오류를 포합합니다.
        print("adDidFailToPresentAppOpenAd error: \(error)")
        AdWhaleAppOpenAd.shared.loadAd()
        startMainScreen()
    }
}
