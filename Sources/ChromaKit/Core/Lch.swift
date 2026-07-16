import Foundation

/// An LCH value in the CIELch color space
public struct Lch: XYZConvertable {
	
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

	/// Creates an Lch value from a Lab color.
    public init(_ lab: Lab) {
		self.init(l: lab.l, c: hypot(lab.a, lab.b), h: hueDegrees(a: lab.a, b: lab.b))
	}

	/// Creates an Lch value from an XYZ (D65) color.
    public init(_ xyz: XYZ) {
		self.init(Lab(xyz))
	}

	/// Creates an Lch value from a gamma-encoded display P3 color.
    public init(_ p3: P3) {
		self.init(XYZ(p3))
	}

	// MARK: Conversions
	
    public var lab: Lab {
		Lab(
			l: l,
			a: cos(h * .pi / 180) * c,
			b: sin(h * .pi / 180) * c
		)
	}
	
	// MARK: Sugar
	
    public var xyz: XYZ { lab.xyz }
}
