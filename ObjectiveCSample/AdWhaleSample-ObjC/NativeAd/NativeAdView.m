//
//  NativeAdView.m
//  AdWhaleSample-ObjC
//
//  Created by FSN on 6/25/24.
//

#import "NativeAdView.h"

@implementation NativeAdView

- (UILabel * _Nonnull)adBodyLabel {
    return _bodyLabel;
}

- (UIButton * _Nonnull)adCallToActionButton {
    return _callToActionButton;
}

- (AdWhaleMediaView * _Nonnull)adMediaView {
    return _mediaView;
}

- (UIImageView * _Nonnull)adProfileIconView {
    return _profileIconView;
}

- (UILabel * _Nonnull)adProfileNameLabel {
    return _profileNameLabel;
}

- (UILabel * _Nonnull)adTitleLabel {
    return _titleLabel;
}

@end
