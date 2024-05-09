//
//  NativeAdView.swift
//  AdWhaleSample-Swift
//
//  Created by FSN on 5/8/24.
//

import UIKit
import AdWhaleSDK

class NativeAdView: AdWhaleNativeAdView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var callToActionButton: UIButton!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileIconView: UIImageView!
    @IBOutlet var adWhaleMediaView: AdWhaleMediaView!
    
    override func adTitleLabel() -> UILabel {
        return titleLabel
    }
    
    override func adBodyLabel() -> UILabel {
        return bodyLabel
    }
    
    override func adCallToActionButton() -> UIButton {
        return callToActionButton
    }
    
    override func adProfileNameLabel() -> UILabel {
        return profileNameLabel
    }
    
    override func adProfileIconView() -> UIImageView {
        return profileIconView
    }
    
    override func adMediaView() -> AdWhaleMediaView {
        return adWhaleMediaView
    }

}
