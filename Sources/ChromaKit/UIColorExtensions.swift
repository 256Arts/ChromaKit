#if canImport(UIKit)
import UIKit

public extension UIColor {
    
    convenience init(_ p3: P3, alpha: Double = 1.0) {
        self.init(displayP3Red: p3.r, green: p3.g, blue: p3.b, alpha: alpha)
    }
    
    convenience init(_ xyzConvertable: XYZConvertable, alpha: Double = 1.0) {
        self.init(xyzConvertable.p3, alpha: alpha)
    }

}

public extension P3 {

    /// Creates a display P3 value from a `UIColor`, or `nil` if it can't be converted to display P3.
    init?(_ uiColor: UIColor) {
        guard let space = CGColorSpace(name: CGColorSpace.displayP3),
              let converted = uiColor.cgColor.converted(to: space, intent: .defaultIntent, options: nil),
              let components = converted.components, components.count >= 3 else { return nil }
        self.init(r: components[0], g: components[1], b: components[2])
    }

}
#endif
