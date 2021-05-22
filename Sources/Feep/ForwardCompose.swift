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


public enum CPS {
  public typealias Continuation<T> = (T) -> Void
  public typealias Function<T> = (Continuation<T>) -> Void
  public static func comp<T, U>(_ ƒ1: @escaping Function<T>, _ ƒ2: @escaping (T, Continuation<U>)->Void) -> Function<U> {
    return { continuation in
      ƒ1 { t in
        ƒ2(t) { u in
          continuation(u)
        }
      }
    }
  }
}
