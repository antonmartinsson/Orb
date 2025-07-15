//
//  OrbView.swift
//  Prototype-Orb
//
//  Created by Siddhant Mehta on 2024-11-06.
//
import SwiftUI

public struct OrbView: View {
  @Environment(\.hideBackground) private var hideBackground
  @Environment(\.hideWaves) private var hideWaves
  @Environment(\.hideParticles) private var hideParticles
  @Environment(\.hideGlowEffects) private var hideGlowEffects
  @Environment(\.hideShadow) private var hideShadow
  
  private let config: OrbConfiguration
  
  public init(configuration: OrbConfiguration = OrbConfiguration()) {
    self.config = configuration
  }
  
  public var body: some View {
    GeometryReader { geometry in
      let size = min(geometry.size.width, geometry.size.height)
      
      ZStack {
        // Base gradient background layer
        if !hideBackground {
          background
        }
        
        // Creates depth with rotating glow effects
        baseDepthGlows(size: size)
        
        // Adds organic movement with flowing blob shapes
        if !hideWaves {
          Wave(
            size: size * 1.875,
            rotationSpeed: config.speed * 1.5,
            loopDuration: 60 / config.speed * 1.75,
            offset: size * 0.33
          )
          Wave(
            size: size * 1.25,
            rotationDirection: .counterClockwise,
            rotationSpeed: config.speed * 0.75,
            loopDuration: 60 / config.speed * 2.25,
            offset: size * -0.33,
            maskRotation: .degrees(90)
          )
          .opacity(0.5)
        }
        
        // Adds bright, energetic core glow animations
        if !hideGlowEffects {
          coreGlowEffects(size: size)
        }
        
        // Overlays floating particle effects for additional dynamism
        if !hideParticles {
          particleView
            .frame(maxWidth: size, maxHeight: size)
        }
      }
      // Orb outline for depth
      .overlay {
        realisticInnerGlows
      }
      // Masking out all the effects so it forms a perfect circle
      .mask {
        Circle()
      }
      .aspectRatio(1, contentMode: .fit)
      // Adding realistic, layered shadows so its brighter near the core, and softer as it grows outwards
      .modifier(
        RealisticShadowModifier(
          colors: !hideShadow ? config.backgroundColors : [.clear],
          radius: size * 0.08
        )
      )
    }
  }
  
  private var background: some View {
    LinearGradient(
      colors: config.backgroundColors,
      startPoint: .bottom,
      endPoint: .top
    )
  }
  
  private var orbOutlineColor: LinearGradient {
    LinearGradient(
      colors: [.white, .clear],
      startPoint: .bottom,
      endPoint: .top
    )
  }
  
  private var particleView: some View {
    // Added multiple particle effects since the blurring amounts are different
    ZStack {
      ParticlesView(
        color: config.particleColor,
        speedRange: 10...20,
        sizeRange: 0.5...1,
        particleCount: 10,
        opacityRange: 0...0.3
      )
      .blur(radius: 5)
      
      ParticlesView(
        color: config.particleColor,
        speedRange: 20...30,
        sizeRange: 0.2...1,
        particleCount: 10,
        opacityRange: 0.3...0.8
      )
    }
    .blendMode(.lighten)
  }
  
  private struct Wave: View {
    let size: Double
    let rotationDirection: RotationDirection
    let rotationSpeed: Double
    let loopDuration: Double
    let offset: Double
    let maskRotation: Angle
    
    init(
      size: Double,
      rotationDirection: RotationDirection = .clockwise,
      rotationSpeed: Double,
      loopDuration: Double,
      offset: Double,
      maskRotation: Angle = .degrees(0)
    ) {
      self.size = size
      self.rotationDirection = rotationDirection
      self.rotationSpeed = rotationSpeed
      self.loopDuration = loopDuration
      self.offset = offset
      self.maskRotation = maskRotation
    }
    
    var body: some View {
      RotatingGlowView(
        size: size,
        color: .white.opacity(0.75),
        rotationSpeed: rotationSpeed,
        direction: rotationDirection
      )
      .mask {
        WavyBlobView(
          color: .white.opacity(0.75),
          loopDuration: loopDuration
        )
        .frame(maxWidth: size)
        .offset(x: 0, y: offset)
      }
      .blur(radius: 1)
      .blendMode(.lighten)
    }
  }
  
  private func coreGlowEffects(size: CGFloat) -> some View {
    ZStack {
      RotatingGlowView(
        size: size,
        color: config.glowColor,
        rotationSpeed: config.speed * 3,
        direction: .clockwise
      )
      .blur(radius: size * 0.08)
      .opacity(config.coreGlowIntensity)
      
      RotatingGlowView(
        size: size,
        color: config.glowColor,
        rotationSpeed: config.speed * 2.3,
        direction: .clockwise
      )
      .blur(radius: size * 0.06)
      .opacity(config.coreGlowIntensity)
      .blendMode(.plusLighter)
    }
    .padding(size * 0.08)
  }
  
  // New combined function replacing outerGlow and outerRing
  private func baseDepthGlows(size: CGFloat) -> some View {
    ZStack {
      // Outer glow (previously outerGlow function)
      RotatingGlowView(
        size: size,
        color: config.glowColor,
        rotationSpeed: config.speed * 0.75,
        direction: .counterClockwise
      )
      .padding(size * 0.03)
      .blur(radius: size * 0.06)
      .rotationEffect(.degrees(180))
      .blendMode(.destinationOver)
      
      // Outer ring (previously outerRing function)
      RotatingGlowView(
        size: size,
        color: config.glowColor.opacity(0.5),
        rotationSpeed: config.speed * 0.25,
        direction: .clockwise
      )
      .frame(maxWidth: size * 0.94)
      .rotationEffect(.degrees(180))
      .padding(8)
      .blur(radius: size * 0.032)
    }
  }
  
  private var realisticInnerGlows: some View {
    ZStack {
      // Outer stroke with heavy blur
      Circle()
        .stroke(orbOutlineColor, lineWidth: 8)
        .blur(radius: 32)
        .blendMode(.plusLighter)
      
      // Inner stroke with light blur
      Circle()
        .stroke(orbOutlineColor, lineWidth: 4)
        .blur(radius: 12)
        .blendMode(.plusLighter)
      
      Circle()
        .stroke(orbOutlineColor, lineWidth: 1)
        .blur(radius: 4)
        .blendMode(.plusLighter)
    }
    .padding(1)
  }
}

#Preview {
  let cosmicOrb = OrbConfiguration(
    backgroundColors: [.purple, .pink, .orange],
    glowColor: .white.opacity(0.1),
    particleColor: .white.opacity(0.2),
    coreGlowIntensity: 1.5,
    speed: 20
  )
  ZStack {
    OrbView(configuration: cosmicOrb)
      .aspectRatio(1, contentMode: .fit)
      .padding(36)
  }
}
