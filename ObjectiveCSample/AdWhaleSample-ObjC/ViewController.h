//
//  ViewController.h
//  AdWhaleSample-ObjC
//
//  Created by FSN on 3/29/24.
//

#import <UIKit/UIKit.h>
#import "NativeAd/NativeAdView.h"
@import AdWhaleSDK;

@interface ViewController : UIViewController<AdWhaleBannerDelegate, AdWhaleInterstitialDelegate, AdWhaleRewardDelegate, AdWhaleNativeAdLoaderDelegate, AdWhaleNativeAdDelegate> {
    AdWhaleInterstitialAd *interstitialAd;
    AdWhaleRewardAd *rewardAd;
    AdWhaleNativeAdLoader *nativeAdLoader;
}

@property (strong, nonatomic) IBOutlet AdWhaleBannerAd *bannerView;

- (IBAction)showAdInspector:(id)sender;
- (IBAction)bannerAdRequest:(id)sender;
- (IBAction)interstitialAdRequest:(id)sender;
- (IBAction)interstitialAdShow:(id)sender;
- (IBAction)rewardAdRequest:(id)sender;
- (IBAction)rewardAdShow:(id)sender;
- (IBAction)nativeAdRequest:(id)sender;

- (void)setNativeAdView;
@end

