import XCTest
@testable import ChromaKit

func XCTAssertEqualP3(
	_ a: P3,
	_ b: P3,
	accuracy: Double = 0.001,
	file: StaticString = #filePath,
	line: UInt = #line
) {
	XCTAssertEqual(a.r, b.r, accuracy: accuracy, file: file, line: line)
	XCTAssertEqual(a.g, b.g, accuracy: accuracy, file: file, line: line)
	XCTAssertEqual(a.b, b.b, accuracy: accuracy, file: file, line: line)
}

final class ChromaKitTests: XCTestCase {
	let nativeP3 = P3(r: 0.8, g: 0.6, b: 0.4)
	
    func testLch() throws {
		let lch = Lch(l: 67.21298, c: 43.18819, h: 66.09192)
		XCTAssertEqualP3(lch.p3, nativeP3)
    }
	
	func testOklch() throws {
		let oklch = Oklch(l: 0.72385, c: 0.10601, h: 62.26385)
		print(oklch.xyz)
		XCTAssertEqualP3(oklch.p3, nativeP3)
	}
	
    func testLab() throws {
		let lab = Lab(l: 67.21298, a: 17.5029, b: 39.48251)
		XCTAssertEqualP3(lab.p3, nativeP3)
    }
	
    func testOklab() throws {
		let oklab = Oklab(l: 0.72385, a: 0.04934, b: 0.09383)
		print(oklab.xyz)
		XCTAssertEqualP3(oklab.p3, nativeP3)
    }

	// MARK: Reverse conversions

	func testLchFromP3() throws {
		let lch = Lch(nativeP3)
		XCTAssertEqual(lch.l, 67.21298, accuracy: 0.01, "l")
		XCTAssertEqual(lch.c, 43.18819, accuracy: 0.01, "c")
		XCTAssertEqual(lch.h, 66.09192, accuracy: 0.01, "h")
	}

	func testLabFromP3() throws {
		let lab = Lab(XYZ(nativeP3))
		XCTAssertEqual(lab.l, 67.21298, accuracy: 0.01, "l")
		XCTAssertEqual(lab.a, 17.5029, accuracy: 0.01, "a")
		XCTAssertEqual(lab.b, 39.48251, accuracy: 0.01, "b")
	}

	func testOklchFromP3() throws {
		let oklch = Oklch(nativeP3)
		XCTAssertEqual(oklch.l, 0.72385, accuracy: 0.0001, "l")
		XCTAssertEqual(oklch.c, 0.10601, accuracy: 0.0001, "c")
		XCTAssertEqual(oklch.h, 62.26385, accuracy: 0.01, "h")
	}

	func testOklabFromP3() throws {
		let oklab = Oklab(XYZ(nativeP3))
		XCTAssertEqual(oklab.l, 0.72385, accuracy: 0.0001, "l")
		XCTAssertEqual(oklab.a, 0.04934, accuracy: 0.0001, "a")
		XCTAssertEqual(oklab.b, 0.09383, accuracy: 0.0001, "b")
	}

	/// P3 → Oklch → P3 must return the original color.
	func testOklchRoundTrip() throws {
		XCTAssertEqualP3(Oklch(nativeP3).p3, nativeP3)
	}

	/// P3 → Lch → P3 must return the original color.
	func testLchRoundTrip() throws {
		XCTAssertEqualP3(Lch(nativeP3).p3, nativeP3)
	}
}
