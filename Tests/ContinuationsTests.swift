import XCTest
import BlueLine
import Overture
import Feep






class ContinuationsTests: XCTestCase {
  struct User {
    let name: String
    init(name: String) {
      self.name = name
    }
  }
  
  
  struct Image {
    let user: User
    init(user: User) {
      self.user = user
    }
  }
  
  
  func login(completion: CPS.Continuation<User>) {
    completion(User(name: "josh"))
  }
  
  
  func fetchAvatar(for user: User, completion: CPS.Continuation<Image>) {
    completion(Image(user: user))
  }
  

  func thing<T, U>(_ ƒ1: @escaping CPS.Function<T>, transform: @escaping (T)->CPS.Function<U>) -> CPS.Function<U> {
    return { continuation in
      ƒ1 { t in
        return transform(t)(continuation)
      }
    }
  }
  
  
  func dumbFetch(name: String, job: (String)->Void) {
//    let user = User(name: "Dummy")
//    completion(Image(user: user))
  }
  
  
  func testMore() {
    let a = Overture.curry(dumbFetch)
    let b = a("hello")
    guard let c = b as? ((String)->Void) -> Void else{
      fatalError("!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    }
    T(true)
//    thing(login) { user -> ((Image)->Void)->Void in
////      let a = curry(self.fetchAvatar)
////      let b = a(user)
////      print(type(of: b))
//      guard let c = self.dumbFetch as? (((Image) -> ()) -> ()) else {
//        fatalError("???????????????????")
//      }
//      return c
//    }() { (image: Image) in
//      EQ("join", image.user.name)
//    }
  }
  
  
  func testThing() {
    login { user in
      fetchAvatar(for: user) { image in
        EQ("josh", image.user.name)
      }
    }
  }
  
  
  func testOther() {
    CPS.comp(login, fetchAvatar)() { it in
      EQ("josh", it.user.name)
    }
  }
}
