//
//  VoteViewPopover4.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import SwiftUI
import UIKit
import ControlKitBase

public struct VoteViewPopover4: View {
    @ObservedObject var viewModel: VoteViewModelObservable
    var config: VoteViewConfig
    let onDismiss: () -> Void
    let onSubmit: () -> Void
    
    @Binding var showSuccessAlert: Bool
    @Binding var showErrorAlert: Bool
    @Binding var errorMessage: String
    
    @State private var selectedVoteId: String?
    
    public init(
        viewModel: VoteViewModelObservable,
        config: VoteViewConfig,
        showSuccessAlert: Binding<Bool>,
        showErrorAlert: Binding<Bool>,
        errorMessage: Binding<String>,
        onDismiss: @escaping () -> Void,
        onSubmit: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.config = config
        self.config = VoteViewPresenter(data: viewModel.response.data, config: config).config
        self._showSuccessAlert = showSuccessAlert
        self._showErrorAlert = showErrorAlert
        self._errorMessage = errorMessage
        self.onDismiss = onDismiss
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        ZStack {
            // Content view background
            config.contentViewBackColor
                .opacity(config.contentViewAlpha)
                .ignoresSafeArea()
            
            // Popup view - bottom aligned
            VStack(spacing: 0) {
                // Header title
                Text(config.title)
                    .font(config.titleFont)
                    .foregroundColor(config.titleColor)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 28)
                    .padding(.top, 60)
                
                // Question view
                VStack(alignment: .leading, spacing: 16) {
                    // Question label
                    Text(config.question)
                        .font(config.questionFont)
                        .foregroundColor(config.questionColor)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Vote options
                    ForEach(voteOptions, id: \.id) { voteOption in
                        VoteItem(
                            vote: voteOption,
                            isSelected: Binding(
                                get: { selectedVoteId == voteOption.id },
                                set: { _ in }
                            ),
                            font: config.voteItemFont,
                            titleColor: config.voteItemColor,
                            title: getOptionTitle(voteOption)
                        ) { selectedVote in
                            selectedVoteId = selectedVote.id
                            viewModel.selectedVoteOption = selectedVote
                        }
                    }
                }
                .padding(16)
                .background(config.questionViewBackColor)
                .cornerRadius(config.questionViewCornerRadius)
                .padding(.horizontal, 14)
                .padding(.top, 33)
                
                // Submit button - top
                Button(action: {
                    onSubmit()
                }) {
                    Text(config.buttonNormalTitle)
                        .font(config.buttonFont)
                        .foregroundColor(config.buttonTitleColor)
                        .frame(width: 178)
                        .frame(height: 42)
                        .background(config.buttonBackColor)
                        .cornerRadius(config.buttonCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: config.buttonCornerRadius)
                                .stroke(config.buttonBorderColor, lineWidth: config.buttonBorderWidth)
                        )
                }
                .padding(.top, 30)
                
                // Close button - bottom
                Button(action: {
                    onDismiss()
                }) {
                    Text(config.closeButtonNormalTitle)
                        .font(config.closeButtonFont)
                        .foregroundColor(config.closeButtonTitleColor)
                        .frame(width: 178)
                        .frame(height: 42)
                        .background(config.closeButtonBackColor)
                        .cornerRadius(config.closeButtonCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: config.closeButtonCornerRadius)
                                .stroke(config.closeButtonBorderColor, lineWidth: config.closeButtonBorderWidth)
                        )
                }
                .padding(.top, 16)
                .padding(.bottom, 30)
            }
            .background(config.popupViewBackColor)
            .cornerRadius(config.popupViewCornerRadius)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity, alignment: .bottom)
            
            // Alerts
            if showSuccessAlert {
                AlertView(
                    config: config,
                    type: .success,
                    message: config.successMessage,
                    onDismiss: {
                        showSuccessAlert = false
                        onDismiss()
                    }
                )
            }
            
            if showErrorAlert {
                AlertView(
                    config: config,
                    type: .error,
                    message: errorMessage,
                    onDismiss: {
                        showErrorAlert = false
                    }
                )
            }
        }
    }
    
    private var voteOptions: [VoteOption] {
        viewModel.response.data?.vote_options ?? []
    }
    
    private func getOptionTitle(_ voteOption: VoteOption) -> String {
        return getLocalizedString(voteOption.title ?? [], lang: config.lang)
    }
}

public class Popover4VoteViewConfig: VoteViewConfig {
    public override init(lang: CKLanguage) {
        super.init(lang: lang)
        style = .popover4
        buttonTitleColor = .black
        buttonBackColor = Color(r: 255, g: 199, b: 0)
        closeButtonBorderColor = Color(r: 255, g: 199, b: 0)
        closeButtonTitleColor = Color(r: 167, g: 167, b: 167)
        closeButtonFont = Font.system(size: 18, weight: .semibold)
        buttonFont = Font.system(size: 18, weight: .semibold)
        closeButtonBorderWidth = 1.0
        popupViewBackColor = Color(r: 243, g: 243, b: 243)
        questionViewBackColor = .white
        alertSuccessIconColor = Color(r: 255, g: 199, b: 0)
        alertErrorIconColor = .red
        alertSuccessButtonBackgroundColor = Color(r: 255, g: 199, b: 0)
    }
}
