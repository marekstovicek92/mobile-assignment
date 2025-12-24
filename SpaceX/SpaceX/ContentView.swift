//
//  ContentView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI
import FactoryKit

struct ContentView: View {

    let rocketListContainer = RocketListContainer()

    var body: some View {
        rocketListContainer.rocketListView.resolve()
    }
}

#Preview {
    ContentView()
}
