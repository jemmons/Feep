import Foundation



precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}



infix operator >>>: ForwardComposition



public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
  return { a in
    g(f(a))
  }
}
