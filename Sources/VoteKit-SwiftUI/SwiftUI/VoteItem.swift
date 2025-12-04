//
//  VoteItemSwiftUI.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 9/28/25.
//

import SwiftUI
import ControlKitBase

struct VoteItem: View {
    let vote: VoteOption
    @Binding var isSelected: Bool
    let font: Font
    let titleColor: Color
    let title: String
    
    var onTap: (VoteOption) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Button(action: {
                isSelected = true
                onTap(vote)
            }) {
                Image(isSelected ? "selected" : "unselected", bundle: ImageHelper.resolvedBundle)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(title)
                .font(font)
                .foregroundColor(titleColor)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .onTapGesture {
                    isSelected = true
                    onTap(vote)
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

