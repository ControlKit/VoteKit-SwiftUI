//
//  AlertViewSwiftUI.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/13/25.
//

import SwiftUI
import ControlKitBase

public enum AlertType {
    case success
    case error
}

public struct AlertView: View {
    let config: VoteViewConfig
    let type: AlertType
    let message: String
    let onDismiss: (() -> Void)?
    
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0
    
    public init(
        config: VoteViewConfig,
        type: AlertType,
        message: String,
        onDismiss: (() -> Void)? = nil
    ) {
        self.config = config
        self.type = type
        self.message = message
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        ZStack {
            // Background overlay
            config.alertOverlayBackgroundColor
                .ignoresSafeArea()
                .opacity(opacity)
            
            // Container
            VStack(spacing: 0) {
                // Icon
                Image(iconName, bundle: ImageHelper.resolvedBundle)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(iconColor)
                    .frame(width: config.alertIconSize, height: config.alertIconSize)
                    .padding(.top, config.alertIconTopMargin)
                
                // Message
                Text(message)
                    .font(config.alertMessageFont)
                    .foregroundColor(config.alertMessageColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, config.alertHorizontalPadding)
                    .padding(.top, config.alertMessageTopMargin)
                
                // Button
                Button(action: {
                    withAnimation(.easeOut(duration: config.alertFadeAnimationDuration)) {
                        opacity = 0
                        scale = config.alertInitialScale
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.alertFadeAnimationDuration) {
                        onDismiss?()
                    }
                }) {
                    Text(config.alertButtonTitle)
                        .font(config.alertButtonFont)
                        .foregroundColor(config.alertButtonTitleColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: config.alertButtonHeight)
                        .background(buttonBackgroundColor)
                        .cornerRadius(config.alertButtonCornerRadius)
                }
                .padding(.horizontal, config.alertHorizontalPadding)
                .padding(.top, config.alertButtonTopMargin)
                .padding(.bottom, config.alertButtonBottomMargin)
            }
            .frame(width: config.alertContainerWidth)
            .background(config.alertContainerBackgroundColor)
            .cornerRadius(config.alertContainerCornerRadius)
            .shadow(
                color: config.alertContainerShadowColor.opacity(config.alertContainerShadowOpacity),
                radius: config.alertContainerShadowRadius,
                x: config.alertContainerShadowOffset.width,
                y: config.alertContainerShadowOffset.height
            )
            .scaleEffect(scale)
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(
                response: config.alertScaleAnimationDuration,
                dampingFraction: config.alertScaleAnimationDamping,
                blendDuration: config.alertScaleAnimationVelocity
            )) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
    
    private var iconName: String {
        switch type {
        case .success:
            return config.alertSuccessIconName
        case .error:
            return config.alertErrorIconName
        }
    }
    
    private var iconColor: Color {
        switch type {
        case .success:
            return config.alertSuccessIconColor
        case .error:
            return config.alertErrorIconColor
        }
    }
    
    private var buttonBackgroundColor: Color {
        switch type {
        case .success:
            return config.alertSuccessButtonBackgroundColor
        case .error:
            return config.alertErrorButtonBackgroundColor
        }
    }
}

