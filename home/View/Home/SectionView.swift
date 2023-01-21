//
//  SectionView.swift
//  home
//
//  Created by Scott Courtney on 12/23/22.
//

import SwiftUI

struct SectionView: View {
    // MARK: - PROPERTY
    var title: String
    
    @State var rotateClockwise: Bool
    // MARK: - BODY
    
    var body: some View {
            VStack(spacing: 0) {
                Spacer()
                    
                HStack(spacing: 0) {
                    Text(title.uppercased())
                                .font(.footnote)
                                .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: rotateClockwise ? 90 : -90))
                }//: HSTACK
                .fixedSize()
                .frame(maxWidth: 60)
                    
                Spacer()
            }//: VSTACK
            .background(Color.gray.cornerRadius(12))
            .frame(width: 85)
    }
}
