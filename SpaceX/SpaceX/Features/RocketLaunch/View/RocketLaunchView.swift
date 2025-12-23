//
//  RocketLaunchView.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 22.12.2025.
//

import SwiftUI

struct RocketLaunchView: View {
    
    @State var viewModel: RocketLaunchViewModel

    var body: some View {
        GeometryReader { proxy in
            VStack {
                if viewModel.isLifted {
                    Image(.rocketFlying)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 145)
                        .offset(y: viewModel.launchOffset)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                viewModel.launchOffset = -proxy.size.height
                            }
                        }
                } else {
                    Image(.rocketIdle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 145)
                    Text("Move your phone up to launch the rocket")
                }
            }
            .task {
                viewModel.launchOffset = 0
                await viewModel.onAppear()
            }
            .onDisappear {
                viewModel.stopDetectingMotion()
            }
            .onChange(of: viewModel.isLifted) { _, newValue in
                if newValue {
                    viewModel.launchOffset = 0
                    withAnimation(.easeIn(duration: 1.2)) {
                        viewModel.launchOffset = -proxy.size.height
                    }
                } else {
                    viewModel.launchOffset = 0
                }
            }
            .navigationTitle("Launch")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    RocketLaunchView(
        viewModel: RocketLaunchViewModel(
            motionDetectionUseCase: MotionDetectionUseCase(
                repository: MotionDetectionRepository()
            )
        )
    )
}
