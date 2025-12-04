//
//  VoteKitSwiftUI.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/21/23.
//

import Foundation
import SwiftUI
import UIKit
import ControlKitBase

public let voteKit_Version: String = "1.0.0"
public class VoteKit: Votable {
    public let voteService: GenericServiceProtocol
    
    public init(voteService: GenericServiceProtocol = GenericService()) {
        self.voteService = voteService
    }
    
    @MainActor
    public func configure(
        config: VoteServiceConfig
    ) async {
        let request = VoteRequest(
            appId: config.appId,
            name: config.name,
            sdkVersion: config.sdkVersion
        )
        do {
            guard let response = try await self.getVote(request: request)?.value else {
                return
            }
            guard let id = response.data?.id,
                  id > UserDefaults.standard.string(forKey: getName(config.name)) ?? String() else {
                return
            }
            
            let viewModel = DefaultVoteViewModel(
                serviceConfig: config,
                response: response
            )
            
            let observableViewModel = VoteViewModelObservable(viewModel: viewModel)
            
            let voteView = VoteView(
                viewModel: observableViewModel,
                config: config
            )
            
            NavigationView {
                voteView
                .navigationBarTitleDisplayMode(.inline)
            }
        } catch {
            return
        }
    }
}

