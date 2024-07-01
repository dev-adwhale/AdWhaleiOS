//
//  ViewController.m
//  AdWhaleSample-ObjC
//
//  Created by FSN on 3/29/24.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // SDK GDPR 설정
    [[AdWhaleAds sharedInstance] gdpr:self testDevices:nil completionHandler:^(BOOL result) {
        // GDPR 설정 완료 후 동작 코드
        
        // BannerView Setting
        [self.bannerView setAdSize:AdWhaleAdSizeBanner];
        [self.bannerView setAdUnitID:@"ca-app-pub-3940256099942544/2934735716"];
        [self.bannerView setRootViewController:self];
        [self.bannerView setDelegate:self];
    }];
    
    /** 프로그램 코드 방식으로 배너 구현하는 경우 적용 **/
//    CGRect frame = CGRectMake(0,
//                              500,
//                              UIScreen.mainScreen.bounds.size.width,
//                              50);
//    self.bannerView = [[AdWhaleBannerAd alloc] initWithFrame:frame];
//    [self.view addSubview:self.bannerView];
    /** 프로그램 코드 방식으로 배너 구현하는 경우 적용 **/
}

// Ad inspector 코드 방식 호출
- (IBAction)showAdInspector:(id)sender {
    [[AdWhaleAds sharedInstance] showAdInspectorWithViewController:self];
}

#pragma mark - Banner Ad Request
- (IBAction)bannerAdRequest:(id)sender {
    NSLog(@"banner Ad Request");
    [self.bannerView load];
}


#pragma mark - Interstitial Ad Request & Show
- (IBAction)interstitialAdRequest:(id)sender {
    AdWhaleInterstitialAd *interstitial = [[AdWhaleInterstitialAd alloc] init];
    interstitial.interstitialDelegate = self;
    [interstitial load:@"ca-app-pub-3940256099942544/4411468910"];
}


- (IBAction)interstitialAdShow:(id)sender {
    NSLog(@"interstitial Ad Show");
    [interstitialAd show:self];
}


#pragma mark - Reward Ad Request & Show
- (IBAction)rewardAdRequest:(id)sender {
    AdWhaleRewardAd *reward = [[AdWhaleRewardAd alloc] init];
    reward.rewardDelegate = self;
    [reward load:@"ca-app-pub-3940256099942544/1712485313"];
}


- (IBAction)rewardAdShow:(id)sender {
    NSLog(@"reward Ad Show");
    [rewardAd show:self];
}


#pragma mark - Native Ad Request
- (IBAction)nativeAdRequest:(id)sender {
    AdWhaleNativeAdLoader *adLoader = [AdWhaleNativeAdLoader sharedInstance];
    [adLoader initializeWithAdUnitId:@"ca-app-pub-3940256099942544/3986624511" rootViewController:self];
    adLoader.delegate = self;
    [adLoader loadAd];
}

- (void)setNativeAdView {
    NativeAdView *nativeAdView = [[[NSBundle mainBundle] loadNibNamed:@"NativeAdView" owner:nil options:nil] firstObject];
    
    nativeAdView.frame = CGRectMake(10,
                                    [UIScreen mainScreen].bounds.size.height - 430,
                                    [UIScreen mainScreen].bounds.size.width - 20,
                                    350);
    AdWhaleNativeAdView *adView = [[AdWhaleNativeAdLoader sharedInstance] bindView:nativeAdView];
    [self.view addSubview:adView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - BannerAd Delegate

- (void)bannerViewDidReceiveAd:(AdWhaleBannerAd *)bannerView {
    NSLog(@"ViewController bannerViewDidReceiveAd");
}

- (void)bannerView:(AdWhaleBannerAd *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"ViewController didFailToReceiveAdWithError: %@", error.localizedDescription);
}

- (void)bannerViewDidRecordImpression:(AdWhaleBannerAd *)bannerView {
    NSLog(@"ViewController bannerViewDidRecordImpression");
}

- (void)bannerViewWillPresentScreen:(AdWhaleBannerAd *)bannerView {
    NSLog(@"ViewController bannerViewWillPresentScreen");
}

- (void)bannerViewWillDismissScreen:(AdWhaleBannerAd *)bannerView {
    NSLog(@"ViewController bannerViewWillDismissScreen");
}

- (void)bannerViewDidDismissScreen:(AdWhaleBannerAd *)bannerView {
    NSLog(@"ViewController bannerViewDidDismissScreen");
}


#pragma mark - InterstitialAd Delegate

- (void)adDidReceiveInterstitialAd:(AdWhaleInterstitialAd *)ad {
    NSLog(@"adWhale Sample adDidReceiveInterstitialAd");
    interstitialAd = ad;
}

- (void)adDidFailToReceiveInterstitialAdWithError:(NSError *)error {
    NSLog(@"adWhale Sample adDidFailToReceiveInterstitialAdWithError");
}

- (void)ad:(AdWhaleInterstitialAd *)ad didFailToPresentInterstitialAdWithError:(NSError *)error {
    NSLog(@"adWhale Sample didFailToPresentInterstitialAdWithError: %@", error);
}

- (void)adWillPresentInterstitialAd:(AdWhaleInterstitialAd *)ad {
    NSLog(@"adWhale Ad will present Interstitial ad.");
}

- (void)adDidDismissInterstitialAd:(AdWhaleInterstitialAd *)ad {
    NSLog(@"adWhale Ad did dismiss Interstitial ad.");
}

#pragma mark - RewardAd Delegate

- (void)adDidReceiveRewardAd:(AdWhaleRewardAd *)ad {
    NSLog(@"AdWhaleSample adDidReceiveRewardAd");
    rewardAd = ad;
}

- (void)adDidEarnReward:(AdWhaleReward *)reward {
    NSLog(@"AdWhaleSample %@, amount %f, reward type %@", reward.amount, reward.amount.doubleValue, reward.type);
}

- (void)ad:(AdWhaleRewardAd *)ad didFailToPresentRewardAdWithError:(NSError *)error {
    NSLog(@"AdWhaleSample didFailToPresentRewardAdWithError: %@", error);
}

- (void)adDidFailToReceiveRewardAdWithError:(NSError *)error {
    NSLog(@"AdWhaleSample adDidFailToReceiveRewardAdWithError: %@", error);
}

- (void)adWillPresentRewardAd:(AdWhaleRewardAd *)ad {
    NSLog(@"AdWhaleSample adWillPresentRewardAd");
}

- (void)adDidDismissRewardAd:(AdWhaleRewardAd *)ad {
    NSLog(@"AdWhaleSample adDidDismissRewardAd");
}

#pragma mark - NativeAd Delegate

- (void)nativeAdLoaderDidReceiveAd:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"Received native ad: %@", nativeAd);
    nativeAd.delegate = self;
    [self setNativeAdView];
}

- (void)nativeAdLoaderDidFailToReceiveAd:(AdWhaleNativeAdLoader *)nativeAdLoader error:(NSError *)error {
    NSLog(@"adLoader didFailToAdWithError %@", error.localizedDescription);
}

- (void)nativeAdDidClickAd:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"nativeAdDidClickAd");
}

- (void)nativeAdDidImpression:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"nativeAdDidImpression");
}

- (void)nativeAdWillPresentScreen:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"nativeAdWillPresentScreen");
}

- (void)nativeAdWillDismissScreen:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"nativeAdWillDismissScreen");
}

- (void)nativeAdDidDismissScreen:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"nativeAdDidDismissScreen");
}

- (void)nativeAdWillLeaveApplication:(AdWhaleNativeAd *)nativeAd {
    NSLog(@"nativeAdWillLeaveApplication");
}


@end
