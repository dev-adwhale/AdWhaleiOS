//
//  SplashViewController.m
//  AdWhaleSample-ObjC
//
//  Created by FSN on 6/21/24.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AdWhaleAppOpenAd.shared.adUnitId = @"ca-app-pub-3940256099942544/5575463023";
    AdWhaleAppOpenAd.shared.appOpenAdDelegate = self;
}

// Main 화면으로 이동
- (void)startMainScreen {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self presentViewController:mainViewController animated:YES completion:^{
        [self dismissViewControllerAnimated:NO completion:^{
            UIWindow *keyWindow = [[UIApplication sharedApplication].windows firstObject];
            keyWindow.rootViewController = mainViewController;
        }];
    }];
}

#pragma mark - AppOpenAd Delegate

- (void)adDidReceiveAppOpenAd:(AdWhaleAppOpenAd *)ad {
    // 광고 로드가 완료되면 메소드가 실행됩니다.
    NSLog(@"adDidReceiveAppOpenAd");
    
    // AppOpen 광고 표시
    [AdWhaleAppOpenAd.shared showAdIfAvailable:self];
}

- (void)adDidFailToReceiveAppOpenAdWithError:(NSError * _Nonnull)error {
    // 광고 로드가 실패하고 발생한 오류를 포함합니다.
    NSLog(@"adDidFailToReceiveAppOpenAd sample error: %@", error.localizedDescription);
    [self startMainScreen];
}

- (void)adWillPresentAppOpenAd {
    // 광고가 전체 화면 콘텐츠를 표시할 때 호출됩니다.
    NSLog(@"adWillPresentAppOpenAd");
}

- (void)adDidDismissAppOpenAd {
    // 전체 화면 콘텐츠를 닫을 때 호출됩니다.
    NSLog(@"adDidDismissAppOpenAd");
    [AdWhaleAppOpenAd.shared loadAd];
    [self startMainScreen];
}

- (void)adDidFailToPresentAppOpenAdWithError:(NSError * _Nonnull)error {
    // 전체 화면 콘텐츠 표시가 실패하고 발생한 오류를 포합합니다.
    NSLog(@"adDidFailToPresentAppOpenAd error: %@", error);
    [AdWhaleAppOpenAd.shared loadAd];
    [self startMainScreen];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
