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
    var nativeAdLoader: AdWhaleNativeAdLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // SDK GDPR 설정
        AdWhaleAds.sharedInstance.gdpr(self, testDevices: nil, completionHandler: { result in
            // GDPR 설정 완료 후 동작 코드
            
            // BannerView Setting
            self.bannerView.setAdSize(.banner)
            self.bannerView.setAdUnitID("ca-app-pub-3940256099942544/2934735716")
            self.bannerView.setRootViewController(self)
            self.bannerView.setDelegate(self)
        })
        
        
        /** 프로그램 코드 방식으로 배너 구현하는 경우 적용  **/
//        let frame = CGRect(x: 0,
//                           y: 500,
//                           width: UIScreen.main.bounds.width,
//                           height: 50)
//        
//        bannerView = AdWhaleBannerAd(frame: frame)
//        view.addSubview(bannerView)
        /** 프로그램 코드 방식으로 배너 구현하는 경우 적용 **/
    }
    
    // Ad inspector 코드 방식 호출
    @IBAction func showAdInspector(_ sender: UIButton) {
        AdWhaleAds.sharedInstance.showAdInspector(viewController: self)
    }
    
    // MARK: Banner Ad Request
    @IBAction func bannerAdRequest(_ sender: UIButton) {
        print("banner Ad Request")
        // Banner Ad Request
        bannerView.load()
    }
    
    
    // MARK: Interstitial Ad Requset & Show
    @IBAction func interstitialAdRequest(_ sender: UIButton) {
        // Interstitial Ad Setting
        let interstitial = AdWhaleInterstitialAd()
        interstitial.interstitialDelegate = self
        
        // Interstitial Ad Request
        interstitial.load("ca-app-pub-3940256099942544/4411468910")
    }
    
    @IBAction func interstitialAdShow(_ sender: UIButton) {
        print("interstitial Ad Show")
        
        interstitialAd?.show(self)
    }
    
    
    
    // MARK: Reward Ad Request & Show
    @IBAction func rewardAdRequest(_ sender: UIButton) {
        // Reward Ad Setting
        let reward = AdWhaleRewardAd()
        reward.rewardDelegate = self
        
        // Reward Ad Request
        reward.load("ca-app-pub-3940256099942544/1712485313")
    }
    
    @IBAction func rewardAdShow(_ sender: UIButton) {
        print("reward Ad Show")
        
        rewardAd?.show(self)
    }
    
    
    
    // MARK: Native Ad Request
    @IBAction func nativeAdRequest(_ sender: UIButton) {
        // NativeAdLoader Setting
        nativeAdLoader = AdWhaleNativeAdLoader()
        nativeAdLoader?.initialize(adUnitId: "ca-app-pub-3940256099942544/3986624511", rootViewController: self)
        nativeAdLoader?.delegate = self
        
        // Native Ad Request
        nativeAdLoader?.loadAd()
    }
    
    func setNativeAdView() {
        let nibView = Bundle.main.loadNibNamed("NativeAdView", owner: nil)?.first
        guard let nativeAdView = nibView as? NativeAdView else {
            print("NativeAdView is nil")
            return
        }
        
        nativeAdView.frame = CGRect(x: 10,
                                    y: (Int(UIScreen.main.bounds.height) - 430),
                                    width: (Int(UIScreen.main.bounds.width) - 20),
                                    height: 350)
        self.view.addSubview(nativeAdView)
        nativeAdLoader?.bind(nativeAdView)
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
    func adDidReceiveInterstitialAd(_ ad: AdWhaleSDK.AdWhaleInterstitialAd) {
        print("adWhale Sample adDidReceiveInterstitialAd")
        interstitialAd = ad
    }
    
    func adDidFailToReceiveInterstitialAdWithError(_ error: Error) {
        print("adWhale Sample adDidFailToReceiveInterstitialAdWithError")
    }
    
    func ad(_ ad: AdWhaleSDK.AdWhaleInterstitialAd, didFailToPresentInterstitialAdWithError error: Error) {
        print("adWhale Sample didFailToPresentInterstitialAdWithError")
    }
    
    func adWillPresentInterstitialAd(_ ad: AdWhaleSDK.AdWhaleInterstitialAd) {
        print("adWhale Ad will present Interstitial ad.")
    }
    
    func adDidDismissInterstitialAd(_ ad: AdWhaleSDK.AdWhaleInterstitialAd) {
        print("adWhale Ad did dismiss Interstitial ad.")
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

// MARK: NativeAd Delegate
extension ViewController: AdWhaleNativeAdLoaderDelegate, AdWhaleNativeAdDelegate {
    func nativeAdLoaderDidReceiveAd(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("Received native ad: \(nativeAd)")
        
        nativeAd.delegate = self
        
        setNativeAdView()
    }
    
    func nativeAdLoaderDidFailToReceiveAd(_ nativeAd: AdWhaleSDK.AdWhaleNativeAdLoader, error: Error) {
        print("adLoader didFailToAdWithError \(error.localizedDescription)")
    }
    
    func nativeAdDidClickAd(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("nativeAdDidClickAd")
    }
    
    func nativeAdDidImpression(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("nativeAdDidImpression")
    }
    
    func nativeAdWillPresentScreen(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("nativeAdWillPresentScreen")
    }
    
    func nativeAdWillDismissScreen(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("nativeAdWillDismissScreen")
    }
    
    func nativeAdDidDismissScreen(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("nativeAdDidDismissScreen")
    }
    
    func nativeAdWillLeaveApplication(_ nativeAd: AdWhaleSDK.AdWhaleNativeAd) {
        print("nativeAdWillLeaveApplication")
    }
}



