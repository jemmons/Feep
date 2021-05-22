import Foundation



precedencegroup BindOperator {
  associativity: left
}



//The traditional choice here is `>>=` but that's already used by Swift as "bitshift then assign" operator ಠ_ಠ. So we play into the fact that we usually bind Optionals.
infix operator ?=: BindOperator



public func ?= <T, U>(t: T?, f: (T)->U?) -> U? {
  return t.flatMap(f)
}
