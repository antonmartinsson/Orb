<p align="center">
  <a href="https://github.com/metasidd/Orb">
    <img src="https://img.shields.io/github/v/release/metasidd/Orb?style=flat&label=Swift%20Package%20Index&color=red"/>
  </a>
  <a href="https://github.com/metasidd/Orb/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/metasidd/Orb?style=flat"/>
  </a>
  <a href="https://swiftpackageindex.com/metasidd/Orb">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmetasidd%2FOrb%2Fbadge%3Ftype%3Dplatforms"/>
  </a>
  <a href="https://swiftpackageindex.com/metasidd/Orb">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmetasidd%2FOrb%2Fbadge%3Ftype%3Dswift-versions"/>
  </a>
</p>

# 🔮 The Orb - SwiftUI

A beautiful, highly customizable animated orb component using SwiftUI. Create mesmerizing, interactive orbs with glowing effects, particles, and dynamic animations. 

Originally created by [@metasidd](https://github.com/metasidd). Modified by me to reduce reliance on GeometryReader, lower the iOS deployment target and allow for orb customization through view modifiers, instead of a parameter heavy configuration init.

https://github.com/user-attachments/assets/181b5041-df59-40ed-b71b-a9f91292ce0a

(Inspired by Apple's Siri Animations, and [Oğuz's Tweet](https://x.com/oguzyagizkara/status/1853758448166453708)!)

## Installation

### Swift Package Manager

Add Orb as a dependency to your project through Xcode:

1. Go to `File` > `Add Package Dependencies`
2. Enter the repository URL: `https://github.com/metasidd/Orb.git`
3. Click `Add Package`

Or add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Orb.git", from: "1.0.0")
]
```

## Usage

### Basic Implementation

```swift
import Orb
import SwiftUI

struct ContentView: View {
    var body: some View {
        OrbView()
            .frame(width: 200, height: 200)
    }
}
```

### Highly Customizable

![image](https://github.com/user-attachments/assets/4b51ca16-889b-4a0a-80e5-9256c51825b8)

The `OrbView` can be customized using `OrbConfiguration`:

```swift
let configuration = OrbConfiguration(
    backgroundColors: [.purple, .blue, .pink],  // Custom gradient colors
    glowColor: .white,                          // Glow effect color
    particleColor: .white,                      // Particle effect color
    coreGlowIntensity: 1.2,                     // Intensity of the core glow
    speed: 60                                   // Animation speed
)

OrbView(configuration: configuration)
    .frame(width: 200, height: 200)
```

### Available Configuration Options

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `backgroundColors` | `[Color]` | `[.green, .blue, .pink]` | Colors used for the gradient background |
| `glowColor` | `Color` | `.white` | Color of the glow effects |
| `particleColor` | `Color` | `.white` | Color of the particle effects |
| `coreGlowIntensity` | `Double` | `1.0` | Intensity of the core glow effect (higher = brighter) |
| `showBackground` | `Bool` | `true` | Shows/hides the gradient background |
| `showWavyBlobs` | `Bool` | `true` | Shows/hides organic movement elements |
| `showParticles` | `Bool` | `true` | Shows/hides particle effects |
| `showGlowEffects` | `Bool` | `true` | Shows/hides glow effects |
| `showShadow` | `Bool` | `true` | Shows/hides shadow effects |
| `speed` | `Double` | `60` | Animation speed (higher = faster) |

### View modifiers

You can use the following view modifiers to conditionally hide or show certain elements of the orb. By default, they all are set to show.

```swift
.hideBackground(_ hide: Bool)
```

```swift
.hideWaves(_ hide: Bool)
```

```swift
.hideParticles(_ hide: Bool)
```

```swift
.hideGlowEffects(_ hide: Bool)
```

```swift
.hideShadow(_ hide: Bool)
```

## Requirements

- iOS 16.0+
- macOS 14.0+
- tvOS 17.0+
- watchOS 10.0+
- visionOS 1.0+
- Swift 5.9+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
