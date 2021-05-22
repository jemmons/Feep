import Foundation

precedencegroup ForwardApplication {
  associativity: left
}


infix operator |>: ForwardApplication


public func |> <T, U>(t: T, f: (T)->U) -> U {
  return f(t)
}
