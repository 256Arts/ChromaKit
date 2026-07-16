import Foundation

/// An LCH value in the Oklch color space
public struct Oklch: XYZConvertable {
	
	// MARK: Properties
	
    public var l: Double
    public var c: Double
    public var h: Double
    
    // MARK: Init
    
    public init(l: Double, c: Double, h: Double) {
        self.l = l
        self.c = c
        self.h = h
    }

	/// Creates an Oklch value from an Oklab color.
    public init(_ oklab: Oklab) {
		self.init(l: oklab.l, c: hypot(oklab.a, oklab.b), h: hueDegrees(a: oklab.a, b: oklab.b))
	}

	/// Creates an Oklch value from an XYZ (D65) color.
    public init(_ xyz: XYZ) {
		self.init(Oklab(xyz))
	}

	/// Creates an Oklch value from a gamma-encoded display P3 color.
    public init(_ p3: P3) {
		self.init(XYZ(p3))
	}

	// MARK: Conversions
	
    public var oklab: Oklab {
		Oklab(
			l: l,
			a: cos(h * .pi / 180) * c,
			b: sin(h * .pi / 180) * c
		)
	}
	
	// MARK: Sugar
	
    public var xyz: XYZ { oklab.xyz }
}
