import XCTest
import Foundation
import Feep


private enum Helper {
  static func upcase(_ string: String) -> String {
    return string.uppercased()
  }
  
  static func izify(_ string: String) -> String {
    return string + "ize"
  }
}

class FeepTests: XCTestCase {
  func testApplication() {
    XCTAssertEqual("FOO", "foo" |> Helper.upcase)
    XCTAssertEqual("fooize", "foo" |> Helper.izify)
  }
  
  
  func testComposition() {
    XCTAssertEqual("FOOize", "foo" |> Helper.upcase >>> Helper.izify)
    XCTAssertEqual("FOOIZE", "foo" |> Helper.izify >>> Helper.upcase)
  }
  
  
  func testBind() {
    let some: String? = "http://example.com"
    let none: String? = nil
    XCTAssertEqual("http://example.com", (some ?= URL.init)!.absoluteString)
    XCTAssertNil(none ?= URL.init)
  }
}
