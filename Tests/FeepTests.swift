import XCTest
import Foundation
import BlueLine
import Overture
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
    EQ("FOO", "foo" |> Helper.upcase)
    EQ("fooize", "foo" |> Helper.izify)
  }
  
  
  func testComposition() {
    EQ("FOOize", "foo" |> Helper.upcase >>> Helper.izify)
    EQ("FOOIZE", "foo" |> Helper.izify >>> Helper.upcase)
  }
  
  
  func testBind() {
    let some: String? = "http://example.com"
    let none: String? = nil
    EQ("http://example.com", (some ?= URL.init)!.absoluteString)
    NIL(none ?= URL.init)
  }
  
  
  func testCurry() {
    let subject = curry(String.init(data:encoding:))
    T(subject is (Data)->(String.Encoding)->String?)
    
    let data = Data("foo".utf8)
    EQ(subject(data)(.utf8), "foo")
  }
  
  
  func testFlip() {
    let subject = Overture.flip(curry(String.init(data:encoding:)))
    T(subject is (String.Encoding)->(Data)->String?)
    
    let data = Data("foo".utf8)
    EQ(subject(.utf8)(data), "foo")
  }
  
  
  func testZurry() {
    let subject = Overture.zurry("foo".uppercased)
    T(subject is String)
    EQ(subject, "FOO")
  }
}
