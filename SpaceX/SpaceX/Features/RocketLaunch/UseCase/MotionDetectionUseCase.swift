//
//  MotionDetectionUseCase.swift
//  SpaceX
//
//  Created by Marek Šťovíček on 23.12.2025.
//

import Foundation

struct MotionDetection {
    let gravity: Gravity
    let attitude: Attitude

    struct Gravity {
        let x: Double
        let y: Double
        let z: Double
    }

    struct Attitude {
        var roll: Double
        var pitch: Double
        var yaw: Double
    }
}

enum Motion {
    case idle
    case up
    case left
    case right
    case down
}

protocol MotionDetectionRepositoryProtocol {
    func startMotionDetection() -> AsyncStream<MotionDetection>
}

protocol MotionDetectionUseCaseProtocol {
    func motionDetection() -> AsyncStream<Motion>
    func stopMotionDetection()
}

class MotionDetectionUseCase: MotionDetectionUseCaseProtocol {

    private let repository: MotionDetectionRepositoryProtocol
    private var task: Task<Void, Never>?
    private var baselineGravity: MotionDetection.Gravity?

    init(repository: MotionDetectionRepositoryProtocol) {
        self.repository = repository
    }

    func motionDetection() -> AsyncStream<Motion> {
        AsyncStream { continuation in
            let stream = repository.startMotionDetection()
            task = Task { [weak self] in
                for await value in stream  {
                    if self?.baselineGravity == nil {
                        self?.baselineGravity = value.gravity
                    }
                    if let motion = self?.calculateMotion(from: value) {
                        continuation.yield(motion)
                    }
                }
            }
        }
    }

    func stopMotionDetection() {
        task?.cancel()
        baselineGravity = nil
    }

    private func calculateMotion(from detection: MotionDetection) -> Motion? {
        // Require a valid baseline captured earlier; don't auto-fallback to current sample
        guard let baseline = baselineGravity else { return nil }

        let dx = detection.gravity.x
        let dy = detection.gravity.y
        let dz = detection.gravity.z
        guard dx.isFinite, dy.isFinite, dz.isFinite else { return nil }

        // Detect if the phone is lying flat on its back/front using gravity.
        // When the device is flat, the z-axis should be close to ±1g and x/y near 0.
        // Tune thresholds as needed for your noise profile.
        let flatZThreshold = 0.9   // |z| >= 0.9g means mostly perpendicular to ground
        let flatXYThreshold = 0.15 // |x| and |y| below this considered near-flat
        if abs(dz) >= flatZThreshold && abs(dx) < flatXYThreshold && abs(dy) < flatXYThreshold {
            return .idle
        }

        // Compute relative gravity components
        let gx = dx - baseline.x
        let gy = dy - baseline.y

        // Dead zone threshold (in g's). Tune as needed.
        let threshold = 0.15

        // If both components are small, ignore.
        if abs(gx) < threshold && abs(gy) < threshold {
            return nil
        }

        // Decide by the dominant axis
        if abs(gx) > abs(gy) {
            return gx > 0 ? .right : .left
        } else {
            return gy > 0 ? .down : .up
        }
    }
}

