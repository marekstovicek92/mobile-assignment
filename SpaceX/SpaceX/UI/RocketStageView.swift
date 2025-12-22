//
//  RocketStageView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

struct RocketStageView: View {

    let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(content.title)
                .font(.system(size: 18, weight: .bold))
                .padding([.leading, .top], 8)
            makeRow(for: .reusable, text: content.isReusable ? "reusable" : "not reusable")
            makeRow(for: .engine, text: "\(content.engines) engines")
            makeRow(for: .fuel, text: "\(content.fuelInTons) tons of fuel")
            makeRow(for: .burn, text: "\(content.burnTimeInSeconds) seconds burn time")
                .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.black.opacity(0.1))
        )
    }

    func makeRow(for image: ImageResource, text: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            Text(text)
                .font(.system(size: 14))
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
    }
}

extension RocketStageView {
    struct Content: Identifiable, Hashable {
        let id: String
        let title: String
        let isReusable: Bool
        let engines: Int
        let fuelInTons: Double
        let burnTimeInSeconds: Int
    }
}

#Preview {
    RocketStageView(
        content: .init(
            id: UUID().uuidString,
            title: "Title",
            isReusable: true,
            engines: 10,
            fuelInTons: 200,
            burnTimeInSeconds: 300
        )
    )
}
