//
//  OrbConfiguration.swift
//  Orb
//
//  Created by Siddhant Mehta on 2024-11-08.
//

import SwiftUI

public struct OrbConfiguration {
  public let glowColor: Color
  public let backgroundColors: [Color]
  public let particleColor: Color
  
  public let coreGlowIntensity: Double
  public let speed: Double
  
  public init(
    backgroundColors: [Color] = [.green, .blue, .pink],
    glowColor: Color = .white,
    particleColor: Color = .white,
    coreGlowIntensity: Double = 1.0,
    speed: Double = 60
  ) {
    self.backgroundColors = backgroundColors
    self.glowColor = glowColor
    self.particleColor = particleColor
    self.coreGlowIntensity = coreGlowIntensity
    self.speed = speed
  }
}

extension EnvironmentValues {
  @Entry var hideBackground: Bool = false
  @Entry var hideWaves: Bool = false
  @Entry var hideParticles: Bool = false
  @Entry var hideGlowEffects: Bool = false
  @Entry var hideShadow: Bool = false
}

extension View {
  public func hideOrbBackground(_ hide: Bool = true) -> some View {
    environment(\.hideBackground, hide)
  }
  
  public func hideOrbWaves(_ hide: Bool = true) -> some View {
    environment(\.hideWaves, hide)
  }
  
  public func hideOrbParticles(_ hide: Bool = true) -> some View {
    environment(\.hideParticles, hide)
  }
  
  public func hideOrbGlowEffects(_ hide: Bool = true) -> some View {
    environment(\.hideGlowEffects, hide)
  }
  
  public func hideOrbShadow(_ hide: Bool = true) -> some View {
    environment(\.hideShadow, hide)
  }
}
