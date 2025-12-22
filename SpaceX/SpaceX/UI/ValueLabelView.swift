//
//  ValueLabelView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

struct ValueLabelView: View {

    let value: String
    let label: String
    let backgroundColor: Color = .pink.opacity(0.8)

    var body: some View {
        VStack {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top, 24)
            Text(label)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
        )
    }
}

#Preview {
    ValueLabelView(value: "10m", label: "diameter")
}
