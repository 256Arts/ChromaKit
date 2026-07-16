import Foundation

/// A LAB value in the Oklab color space
public struct Oklab: XYZConvertable {
	
	// MARK: Properties
	
    public var l: Double
    public var a: Double
    public var b: Double
    
    // MARK: Init
    
    public init(l: Double, a: Double, b: Double) {
        self.l = l
        self.a = a
        self.b = b
    }

	/// Creates an Oklab value from an XYZ (D65) color.
    public init(_ xyz: XYZ) {
		let xyzToLms = ColorMatrix(
			x: (0.8190224379967030,  0.3619062600528904, -0.1288737815209879),
			y: (0.0329836539323885,  0.9292868615863434,  0.0361446663506424),
			z: (0.0481771893596242,  0.2642395317527308,  0.6335478284694309)
		)

		let lmsToOklab = ColorMatrix(
			x: (0.2104542683093140,  0.7936177747023054, -0.0040720430116193),
			y: (1.9779985324311684, -2.4285922420485799,  0.4505937096174110),
			z: (0.0259040424655478,  0.7827717124575296, -0.8086757549230774)
		)

		let lms = xyzToLms.dotProduct((xyz.x, xyz.y, xyz.z))
		let (l, a, b) = lmsToOklab.dotProduct((cbrt(lms.0), cbrt(lms.1), cbrt(lms.2)))
		self.init(l: l, a: a, b: b)
	}

	// MARK: Conversions
	
    public var xyz: XYZ {
		let lmsToXyz = ColorMatrix(
			x: ( 1.2268798733741557,  -0.5578149965554813,  0.28139105017721583),
			y: (-0.04057576262431372,  1.1122868293970594, -0.07171106666151701),
			z: (-0.07637294974672142, -0.4214933239627914,  1.5869240244272418)
		)
		
		let oklabToLms = ColorMatrix(
			x: (0.99999999845051981432,  0.39633779217376785678,   0.21580375806075880339),
			y: (1.0000000088817607767,  -0.1055613423236563494,   -0.063854174771705903402),
			z: (1.0000000546724109177,  -0.089484182094965759684, -1.2914855378640917399)
		)
		
		let lms = oklabToLms.dotProduct((l, a, b))
		let (x, y, z) = lmsToXyz.dotProduct((pow(lms.0, 3), pow(lms.1, 3), pow(lms.2, 3)))
		return XYZ(x: x, y: y, z: z)
	}
}
