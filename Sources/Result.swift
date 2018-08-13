import Foundation



public enum Result<T> {
  case success(T)
  case failure(Error)
  
  
  public init(_ value: T) {
    self = .success(value)
  }
  
  
  public init(_ error: Error) {
    self = .failure(error)
  }
  
  
  public func map<U>(transform ƒ: (T)->U) -> Result<U> {
    switch self {
    case .success(let t):
      return .success(ƒ(t))
    case .failure(let e):
      return .failure(e)
    }
  }

  
  public func flatMap<U>(transform ƒ: (T) throws -> Result<U>) -> Result<U> {
    switch self {
    case .success(let t):
      do {
        return try ƒ(t)
      } catch {
        return .failure(error)
      }
    case .failure(let e):
      return .failure(e)
    }
  }
  
  
  public func resolve() throws -> T {
    switch self {
    case .success(let t):
      return t
    case .failure(let e):
      throw e
    }
  }
}
