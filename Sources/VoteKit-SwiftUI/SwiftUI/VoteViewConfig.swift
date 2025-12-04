//
//  VoteViewConfigSwiftUI.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/21/23.
//

import Foundation
import SwiftUI
import ControlKitBase

public class VoteViewConfig {
    public init(lang: CKLanguage) {
        self.lang = lang
    }
    public let lang: CKLanguage
    public var style: VoteViewStyle = .fullscreen1
    
    public var contentViewBackColor: Color = Color(red: 0, green: 0, blue: 0, opacity: 0.8)
    public var popupViewBackColor: Color = .white
    public var popupViewCornerRadius: CGFloat = 15.0
    
    public var questionViewBackColor: Color = Color(red: 245/255, green: 245/255, blue: 245/255)
    public var questionViewCornerRadius: CGFloat = 20.0
    
    public var titleFont = Font.system(size: 20, weight: .semibold)
    public var title = "It's a Vote"
    public var titleColor: Color = .black
    
    public var questionFont = Font.system(size: 16, weight: .regular)
    public var question = "It's a Question?"
    public var questionColor: Color = .black
    
    public var voteItemFont = Font.system(size: 16, weight: .regular)
    public var voteItemColor: Color = .black
    
    public var buttonFont = Font.system(size: 16, weight: .semibold)
    public var buttonNormalTitle: String = "Ok"
    public var buttonBackColor: Color = Color(red: 253/255, green: 105/255, blue: 42/255)
    public var buttonTitleColor: Color = .white
    public var buttonCornerRadius: CGFloat = 20.0
    public var buttonBorderWidth: CGFloat = 0.0
    public var buttonBorderColor: Color = .clear
    
    public var closeButtonFont = Font.system(size: 16, weight: .semibold)
    public var closeButtonNormalTitle: String = "Close"
    public var closeButtonBackColor: Color = .clear
    public var closeButtonTitleColor: Color = .orange
    public var closeButtonCornerRadius: CGFloat = 20.0
    public var closeButtonBorderWidth: CGFloat = 0.0
    public var closeButtonBorderColor: Color = Color(red: 253/255, green: 105/255, blue: 42/255)
    public var closeButtonImage: UIImage?
    public var closeButtonImageColor: Color = Color(red: 253/255, green: 105/255, blue: 42/255)
    public var contentViewAlpha: Double = 1.0
    
    public var successMessage: String = "Thanks for Voting!"
    public var errorMessage: String = "Failed to submit. Please try again later.\n"
    
    // MARK: - Alert View Configuration
    // Container
    public var alertContainerBackgroundColor: Color = .white
    public var alertContainerCornerRadius: CGFloat = 16
    public var alertContainerWidth: CGFloat = 300
    public var alertContainerShadowColor: Color = .black
    public var alertContainerShadowOpacity: Double = 0.2
    public var alertContainerShadowOffset: CGSize = CGSize(width: 0, height: 4)
    public var alertContainerShadowRadius: CGFloat = 12
    
    // Overlay
    public var alertOverlayBackgroundColor: Color = Color.black.opacity(0.5)
    
    // Icon
    public var alertIconSize: CGFloat = 60
    public var alertIconTopMargin: CGFloat = 32
    public var alertSuccessIconName: String = "checkmark-circle-fill"
    public var alertErrorIconName: String = "xmark-circle-fill"
    public var alertSuccessIconColor: Color = .green
    public var alertErrorIconColor: Color = .red
    
    // Message
    public var alertMessageFont: Font = Font.system(size: 16, weight: .regular)
    public var alertMessageColor: Color = .gray
    public var alertMessageTopMargin: CGFloat = 12
    
    // Button
    public var alertButtonFont: Font = Font.system(size: 16, weight: .semibold)
    public var alertButtonTitle: String = "OK"
    public var alertButtonCornerRadius: CGFloat = 8
    public var alertButtonHeight: CGFloat = 48
    public var alertButtonTopMargin: CGFloat = 24
    public var alertButtonBottomMargin: CGFloat = 24
    public var alertSuccessButtonBackgroundColor: Color = .green
    public var alertErrorButtonBackgroundColor: Color = .red
    public var alertButtonTitleColor: Color = .white
    
    // Spacing
    public var alertHorizontalPadding: CGFloat = 24
    
    // Animation
    public var alertFadeAnimationDuration: TimeInterval = 0.3
    public var alertScaleAnimationDuration: TimeInterval = 0.5
    public var alertScaleAnimationDamping: Double = 0.7
    public var alertScaleAnimationVelocity: Double = 0.5
    public var alertInitialScale: CGFloat = 0.8
}
