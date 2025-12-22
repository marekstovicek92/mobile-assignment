//
//  RocketLaunchView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

struct RocketLaunchView: View {
    var body: some View {
        VStack {
            Image(.rocketIdle)
                .resizable()
                .scaledToFit()
                .frame(width: 170)
            Text("Move your phone up to launch the rocket")
        }
    }
}

#Preview {
    RocketLaunchView()
}
