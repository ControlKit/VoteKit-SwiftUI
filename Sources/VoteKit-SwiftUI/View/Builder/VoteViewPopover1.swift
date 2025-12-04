//
//  VoteViewPopover1.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import SwiftUI
import UIKit
import ControlKitBase

public struct VoteViewPopover1: View {
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
            
            // Popup view - centered
            VStack(spacing: 0) {
                // Close button - top right
                HStack {
                    Spacer()
                    Button(action: {
                        onDismiss()
                    }) {
                        if let closeImage = config.closeButtonImage {
                            Image(uiImage: closeImage)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(config.closeButtonImageColor)
                                .frame(width: 24, height: 24)
                                .padding(8)
                        } else {
                            Image("close", bundle: ImageHelper.resolvedBundle)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(config.closeButtonImageColor)
                                .frame(width: 24, height: 24)
                                .padding(8)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                }
                
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
                
                Spacer()
                
                // Submit button
                Button(action: {
                    onSubmit()
                }) {
                    Text(config.buttonNormalTitle)
                        .font(config.buttonFont)
                        .foregroundColor(config.buttonTitleColor)
                        .frame(width: 193)
                        .frame(height: 52)
                        .background(config.buttonBackColor)
                        .cornerRadius(config.buttonCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: config.buttonCornerRadius)
                                .stroke(config.buttonBorderColor, lineWidth: config.buttonBorderWidth)
                        )
                }
                .padding(.bottom, 30)
            }
            .background(config.popupViewBackColor)
            .cornerRadius(config.popupViewCornerRadius)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
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

public class Popover1VoteViewConfig: VoteViewConfig {
    public override init(lang: CKLanguage) {
        super.init(lang: lang)
        style = .popover1
        
        alertSuccessIconColor = Color(r: 253, g: 105, b: 42)
        alertErrorIconColor = .red
        alertSuccessButtonBackgroundColor = Color(r: 253, g: 105, b: 42)
    }
}
