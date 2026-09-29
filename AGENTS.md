# ChromaKit

A Swift package for creating and converting colors in the Lch, Lab, Oklch, Oklab, P3, and XYZ
color spaces, and bridging them to native `Color`/`UIColor`/`NSColor`. Conversions are ported
from the CSS Color Module Level 4 sample code, so odd-looking matrix constants and D65
white-point math are intentional — check the spec before "fixing" them. See README.md for usage.

## Build

Single product: library target `ChromaKit` (+ `ChromaKitTests`). Swift tools version 5.9, no
platform floor set in Package.swift (extensions gate themselves per-API with `@available`).

```
swift build
swift test
```

## Structure

- `Sources/ChromaKit/Core/` — the color space types: `XYZ`, `Lab`, `Lch`, `Oklab`, `Oklch`, `P3`,
  plus `ColorMatrix` (3x3 dot-product helper used by the space conversions).
- `Sources/ChromaKit/ColorExtensions.swift`, `UIColorExtensions.swift`, `NSColorExtensions.swift`
  — `init` bridges from the color types to SwiftUI `Color`, `UIKit.UIColor`, `AppKit.NSColor`.
- Data flow: every space converts through `XYZ` as the hub (e.g. `Lab.xyz`, `XYZ(p3)`), and P3 is
  the common gamma-encoded RGB space used for display. `XYZConvertable` is the shared protocol
  central types conform to.
- `Tests/ChromaKitTests/` — `ChromaKitTests.swift` (conversion correctness) and
  `ChromaKitSIMDTests.swift` (SIMD/Accelerate path vs scalar path parity).

## Conventions

- Some conversions (e.g. `XYZ.p3`) branch on `#if canImport(Accelerate)` with an `@available`
  check, falling back to a scalar implementation on older OS versions — keep both paths in sync
  when editing conversion math.
- No git-ignored source files are required to build.
