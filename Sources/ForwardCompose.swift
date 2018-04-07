import Foundation



precedencegroup ForwardComposition {
  associativity: left
  higherThan: ForwardApplication
}



infix operator >>>: ForwardComposition



public func >>> <T, U, V>(f: @escaping (T)->U, g: @escaping (U)->V) -> ((T)->V) {
  return { t in
    g(f(t))
  }
}
