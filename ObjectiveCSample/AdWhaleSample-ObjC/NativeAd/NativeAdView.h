//
//  NativeAdView.h
//  AdWhaleSample-ObjC
//
//  Created by FSN on 6/25/24.
//

#import <UIKit/UIKit.h>
@import AdWhaleSDK;

NS_ASSUME_NONNULL_BEGIN

@interface NativeAdView : UIView <AdWhaleRenderable>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UIButton *callToActionButton;
@property (strong, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileIconView;
@property (strong, nonatomic) IBOutlet AdWhaleMediaView *mediaView;

@end

NS_ASSUME_NONNULL_END
