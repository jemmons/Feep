import Foundation



//public func curry<T,U,V>(_ ƒ: @escaping (T, U)->V) -> (T) -> (U) -> V {
//  return { t in
//    return { u in
//      return ƒ(t, u)
//    }
//  }
//}



public func flip<T,U,V>(_ ƒ: @escaping (T)->(U)->V) -> (U)->(T)->V {
  return { u in
    return { t in
      ƒ(t)(u)
    }
  }
}



public func zurry<T>(_ ƒ:()->T) -> T {
  return ƒ()
}
