//
//  BackgroundView.swift
//  Prototype-Orb
//
//  Created by Siddhant Mehta on 2024-11-06.
//

import SwiftUI

enum RotationDirection {
  case clockwise
  case counterClockwise
  
  var multiplier: Double {
    switch self {
    case .clockwise: return 1
    case .counterClockwise: return -1
    }
  }
}

struct RotatingGlowView: View {
  @State private var rotation: Double = 0
  
  private let size: Double
  private let color: Color
  private let rotationSpeed: Double
  private let direction: RotationDirection
  
  init(
    size: Double,
    color: Color,
    rotationSpeed: Double = 30,
    direction: RotationDirection
  ) {
    self.size = size
    self.color = color
    self.rotationSpeed = rotationSpeed
    self.direction = direction
  }
  
  var body: some View {
    Circle()
      .fill(color)
      .mask {
        ZStack {
          Circle()
            .frame(width: size, height: size)
            .blur(radius: size * 0.16)
          Circle()
            .frame(width: size * 1.31, height: size * 1.31)
            .offset(y: size * 0.31)
            .blur(radius: size * 0.16)
            .blendMode(.destinationOut)
        }
      }
      .rotationEffect(.degrees(rotation))
      .onAppear {
        withAnimation(.linear(duration: 360 / rotationSpeed).repeatForever(autoreverses: false)) {
          rotation = 360 * direction.multiplier
        }
      }
  }
}

#Preview {
  RotatingGlowView(
    size: 128,
    color: .purple,
    rotationSpeed: 30,
    direction: .counterClockwise
  )
  .frame(width: 128, height: 128)
}
