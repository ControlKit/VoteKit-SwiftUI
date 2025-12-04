//
//  VoteViewSwiftUI.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/21/23.
//

import SwiftUI
import ControlKitBase

public struct VoteView: View {
    @ObservedObject var viewModel: VoteViewModelObservable
    let config: VoteServiceConfig
    @Environment(\.dismiss) var dismiss
    
    @State private var showSuccessAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage: String = ""
    
    public init(viewModel: VoteViewModelObservable, config: VoteServiceConfig) {
        self.viewModel = viewModel
        self.config = config
    }
    
    public var body: some View {
        Group {
            switch config.viewConfig.style {
            case .fullscreen1:
                VoteViewFullScreen1(
                    viewModel: viewModel,
                    config: config.viewConfig,
                    showSuccessAlert: $showSuccessAlert,
                    showErrorAlert: $showErrorAlert,
                    errorMessage: $errorMessage,
                    onDismiss: {
                        viewModel.setAction(.cancel)
                        dismiss()
                    },
                    onSubmit: {
                        submitVote()
                    }
                )
            case .popover1:
                VoteViewPopover1(
                    viewModel: viewModel,
                    config: config.viewConfig,
                    showSuccessAlert: $showSuccessAlert,
                    showErrorAlert: $showErrorAlert,
                    errorMessage: $errorMessage,
                    onDismiss: {
                        viewModel.setAction(.cancel)
                        dismiss()
                    },
                    onSubmit: {
                        submitVote()
                    }
                )
            case .popover2:
                VoteViewPopover2(
                    viewModel: viewModel,
                    config: config.viewConfig,
                    showSuccessAlert: $showSuccessAlert,
                    showErrorAlert: $showErrorAlert,
                    errorMessage: $errorMessage,
                    onDismiss: {
                        viewModel.setAction(.cancel)
                        dismiss()
                    },
                    onSubmit: {
                        submitVote()
                    }
                )
            case .popover3:
                VoteViewPopover3(
                    viewModel: viewModel,
                    config: config.viewConfig,
                    showSuccessAlert: $showSuccessAlert,
                    showErrorAlert: $showErrorAlert,
                    errorMessage: $errorMessage,
                    onDismiss: {
                        viewModel.setAction(.cancel)
                        dismiss()
                    },
                    onSubmit: {
                        submitVote()
                    }
                )
            case .popover4:
                VoteViewPopover4(
                    viewModel: viewModel,
                    config: config.viewConfig,
                    showSuccessAlert: $showSuccessAlert,
                    showErrorAlert: $showErrorAlert,
                    errorMessage: $errorMessage,
                    onDismiss: {
                        viewModel.setAction(.cancel)
                        dismiss()
                    },
                    onSubmit: {
                        submitVote()
                    }
                )
            }
        }
        .onAppear {
            viewModel.setAction(.view)
        }
    }
    
    private func submitVote() {
        Task {
            do {
                viewModel.saveLastId()
                let result = try await viewModel.setVote()
                await MainActor.run {
                    switch result {
                    case .failure(let error):
                        errorMessage = config.viewConfig.errorMessage + error.localizedDescription
                        showErrorAlert = true
                    case .success, .noContent:
                        showSuccessAlert = true
                    default:
                        break
                    }
                }
            } catch {
                await MainActor.run {
                    errorMessage = config.viewConfig.errorMessage + error.localizedDescription
                    showErrorAlert = true
                }
            }
        }
    }
}

