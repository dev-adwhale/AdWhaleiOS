//
//  ViewController.swift
//  AdWhaleSample-Swift
//
//  Created by FSN on 3/28/24.
//

import UIKit
import AdWhaleSDK

class ViewController: UIViewController {
    @IBOutlet var bannerView: AdWhaleBannerAd!
    var interstitialAd: AdWhaleInterstitialAd?
    var rewardAd: AdWhaleRewardAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // SDK Init & GDPR 설정
        // useGdpr: true -> GDPR 사용 설정, false -> GDPR 미사용 설정
        // testDevices: ["TEST-DEVICE-ID"] -> GDPR 테스트 모드 설정, nil -> GDPR 테스트 모드 미사용 설정
        AdWhaleAds.sharedInstance.initialize(rootViewController: self, useGdpr: false, testDevices: nil, completionHandler: {
            // SDK 초기화 완료 후 동작 코드
            
            // BannerView Setting
            self.bannerView.setAdSize(.banner)
            self.bannerView.setAdUnitID("ca-app-pub-8713069554470817/3524188366")
            self.bannerView.setRootViewController(self)
            self.bannerView.setDelegate(self)
        })
    }
    
    // Ad inspector 코드 방식 호출
    @IBAction func showAdInspector(_ sender: UIButton) {
        AdWhaleAds.sharedInstance.showAdInspector(viewController: self)
    }
    
    // MARK: Banner Ad Request
    @IBAction func bannerAdRequest(_ sender: UIButton) {
        print("banner Ad Request")
        bannerView.load()
    }
    
    
    // MARK: Interstitial Ad Requset & Show
    @IBAction func interstitialAdRequest(_ sender: UIButton) {
        let interstitial = AdWhaleInterstitialAd()
        interstitial.interstitialDelegate = self
        interstitial.load("ca-app-pub-8713069554470817/9183747144")
    }
    
    @IBAction func interstitialAdShow(_ sender: UIButton) {
        print("interstitial Ad Show")
        
        interstitialAd?.show(self)
    }
    
    
    
    // MARK: Reward Ad Request & Show
    @IBAction func rewardAdRequest(_ sender: UIButton) {
        let reward = AdWhaleRewardAd()
        reward.rewardDelegate = self
        reward.load("ca-app-pub-8713069554470817/3959340629")
    }
    
    @IBAction func rewardAdShow(_ sender: UIButton) {
        print("reward Ad Show")
        
        rewardAd?.show(self)
    }
    
    
    
    // MARK: Native Ad Request
    // 개발 진행중 입니다.
    @IBAction func nativeAdRequest(_ sender: UIButton) {
    }
    
    // MARK: AppOpen Ad Request
    @IBAction func appOpenAdRequest(_ sender: UIButton) {
        AdWhaleAppOpenAd.shared.loadAd("ca-app-pub-8713069554470817/7173349835")
        AdWhaleAppOpenAd.shared.appOpenAdDelegate = self
        AdWhaleAppOpenAd.shared.appOpenAdViewDelegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: BannerAd Delegate
extension ViewController: AdWhaleBannerDelegate {
    func bannerViewDidReceiveAd(_ bannerView: AdWhaleSDK.AdWhaleBannerAd) {
        print("ViewController bannerViewDidReceiveAd")
    }
    
    func bannerView(_ bannerView: AdWhaleSDK.AdWhaleBannerAd, didFailToReceiveAdWithError error: Error) {
        print("ViewController didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    func bannerViewDidRecordImpression(_ bannerView: AdWhaleSDK.AdWhaleBannerAd) {
        print("ViewController bannerViewDidRecordImpression")
    }
    
    func bannerViewWillPresentScreen(_ bannerView: AdWhaleSDK.AdWhaleBannerAd) {
        print("ViewController bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: AdWhaleSDK.AdWhaleBannerAd) {
        print("ViewController bannerViewWillDismissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: AdWhaleSDK.AdWhaleBannerAd) {
        print("ViewController bannerViewDidDismissScreen")
    }
}


// MARK: InterstitialAd Delegate
extension ViewController: AdWhaleInterstitialDelegate {
    func adDidReceiveAd(_ ad: AdWhaleSDK.AdWhaleInterstitialAd) {
        print("adWhale Sample adDidReceiveAd")
        interstitialAd = ad
    }
    
    func adDidFailToReceiveAdWithError(_ error: Error) {
        print("adWhale Sample adDidFailToReceiveAdWithError")
    }
    
    func ad(_ ad: AdWhaleSDK.AdWhaleInterstitialAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("adWhale Sample didFailToPresentFullScreenContentWithError")
    }
    
    func adWillPresentFullScreenContent(_ ad: AdWhaleSDK.AdWhaleInterstitialAd) {
        print("adWhale Ad will present full screen content.")
    }
    
    func adDidDismissFullScreenContent(_ ad: AdWhaleSDK.AdWhaleInterstitialAd) {
        print("adWhale Ad did dismiss full screen content.")
    }
}

// MARK: RewardAd Delegate
extension ViewController: AdWhaleRewardDelegate {
    func adDidReceiveRewardAd(_ ad: AdWhaleSDK.AdWhaleRewardAd) {
        print("AdWhaleSample adDidReceiveRewardAd")
        rewardAd = ad
    }
    
    func adDidEarnReward(_ reward: AdWhaleSDK.AdWhaleReward) {
        print("AdWhaleSample \(reward.amount), amount \(reward.amount.doubleValue), reward type \(reward.type)")
    }
    
    func ad(_ ad: AdWhaleRewardAd, didFailToPresentRewardAdWithError error: Error) {
        print("AdWhaleSample didFailToPresentRewardAdWithError: \(error)")
    }
    
    func adDidFailToReceiveRewardAdWithError(_ error: Error) {
        print("AdWhaleSample adDidFailToReceiveRewardAdWithError: \(error)")
    }
    
    func adWillPresentRewardAd(_ ad: AdWhaleSDK.AdWhaleRewardAd) {
        print("AdWhaleSample adWillPresentRewardAd")
    }
    
    func adDidDismissRewardAd(_ ad: AdWhaleSDK.AdWhaleRewardAd) {
        print("AdWhaleSample adDidDismissRewardAd")
    }
}



// MARK: AppOpenAd Delegate
extension ViewController: AdWhaleAppOpenAdDelegate, AdWhaleAppOpenAdViewDelegate {
    func adDidReceiveAd() {
        print("adDidReceiveAd")
        
        AdWhaleAppOpenAd.shared.showAdIfAvailable(self)
    }
    
    func adWillPresentFullScreenContent() {
        print("adWillPresentFullScreenContent")
    }
    
    func adDidDismissFullScreenContent() {
        print("adDidDismissFullScreenContent")
    }
    
    func adDidFailToPresentFullScreenContentWithError(_ error: Error) {
        print("adDidFailToPresentFullScreenContentWithError: \(error.localizedDescription)")
    }
    
    func appOpenAdDidComplete(_ ad: AdWhaleAppOpenAd) {
        print("appOpenAdDidComplete")
    }
}
