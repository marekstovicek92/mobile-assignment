//
//  MotionDetectionRepository.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 23.12.2025.
//

import Foundation
import CoreMotion

struct MotionDetectionRepository: MotionDetectionRepositoryProtocol {

    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()

    func startMotionDetection() -> AsyncStream<MotionDetection> {
        AsyncStream { continuation in
            if motionManager.isDeviceMotionAvailable {
                motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
                motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: queue) {
                    motion,
                    _ in
                    guard let motion else { return }
                    continuation.yield(
                        .init(
                            gravity: .init(
                                x: motion.gravity.x,
                                y: motion.gravity.y,
                                z: motion.gravity.z
                            ),
                            attitude: .init(
                                roll: motion.attitude.roll,
                                pitch: motion.attitude.pitch,
                                yaw: motion.attitude.yaw
                            )
                        )
                    )
                }
            }

            if motionManager.isAccelerometerAvailable {
                motionManager.accelerometerUpdateInterval = 1.0 / 60.0
                motionManager.startAccelerometerUpdates(to: queue) { data, _ in
                    guard let data else { return }
                    continuation.yield(
                        .init(
                            gravity: .init(
                                x: data.acceleration.x,
                                y: data.acceleration.y,
                                z: data.acceleration.z
                            ),
                            attitude: .init(
                                roll: .zero,
                                pitch: .zero,
                                yaw: .zero
                            )
                        )
                    )
                }
            }
        }
    }
}
