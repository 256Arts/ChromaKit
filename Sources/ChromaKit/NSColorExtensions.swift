// Catalyst can import AppKit but marks NSColor unavailable, so exclude it too.
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit

public extension NSColor {
    
    convenience init(_ p3: P3, alpha: Double = 1.0) {
        self.init(displayP3Red: p3.r, green: p3.g, blue: p3.b, alpha: alpha)
    }
    
    convenience init(_ xyzConvertable: XYZConvertable, alpha: Double = 1.0) {
        self.init(xyzConvertable.p3, alpha: alpha)
    }

}

public extension P3 {

    /// Creates a display P3 value from an `NSColor`, or `nil` if it can't be represented as RGB (e.g. pattern colors).
    init?(_ nsColor: NSColor) {
        guard let color = nsColor.usingColorSpace(.displayP3) else { return nil }
        self.init(r: color.redComponent, g: color.greenComponent, b: color.blueComponent)
    }

}
#endif
