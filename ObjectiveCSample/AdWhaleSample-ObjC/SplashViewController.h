//
//  SplashViewController.h
//  AdWhaleSample-ObjC
//
//  Created by FSN on 6/21/24.
//

#import <UIKit/UIKit.h>
@import AdWhaleSDK;

NS_ASSUME_NONNULL_BEGIN

@interface SplashViewController : UIViewController <AdWhaleAppOpenAdDelegate>

- (void)startMainScreen;


@end

NS_ASSUME_NONNULL_END
