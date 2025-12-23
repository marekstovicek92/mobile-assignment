//
//  RocketLaunchViewModel.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 23.12.2025.
//

import Foundation
import CoreMotion

@Observable
final class RocketLaunchViewModel {

    var isLifted: Bool = false
    var launchOffset: CGFloat = 0

    private let motionDetectionUseCase: MotionDetectionUseCaseProtocol

    init(motionDetectionUseCase: MotionDetectionUseCaseProtocol) {
        self.motionDetectionUseCase = motionDetectionUseCase
    }

    @MainActor
    func onAppear() async {
        let stream = motionDetectionUseCase.motionDetection()
        for await motion in stream {
            if motion == .idle {
                isLifted = false
                continue
            }
            let shouldStart = motion == .up
            if shouldStart != isLifted { isLifted = shouldStart }
        }
    }

    func stopDetectingMotion() {
        motionDetectionUseCase.stopMotionDetection()
    }
}
