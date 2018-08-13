import UIKit
import Feep

typealias JSON = [String: Int]

enum MyError: Error {
  case err
}

func get(url: URL, completion: (Result<JSON>)->Void) {
//  completion(.failure(MyError.err))
  completion(.success(["value": 42]))
}


func fetchInt1(completion: (Result<Int>)->Void) {
  let url = URL(string: "http://example.com")!
  get(url: url) { res in
    switch res {
    case .success(let json):
      completion(.success(json["value"]!))
    case .failure(let e):
      completion(.failure(e))
    }
  }
}


func fetchInt2(completion: (Result<Int>)->Void) {
  let url = URL(string: "http://example.com")!
  get(url: url) { res in
    completion(res.flatMap { json in
      .success(json["value"]!)
    })
  }
}


func fetchInt(completion: (Result<Int>)->Void) {
  let url = URL(string: "http://example.com")!
  
//  get(URL, (Result<JSON>)->Void) -> Void
//  flatMap((JSON)->Result<Int>) -> Result<Int>
//  cpsFlatMap((JSON)->Result<Int>, (Result<Int>)->Void) -> Void
  
  get(url: url) { res in
    completion(res.flatMap { json in
      .success(json["value"]!)
    })
  }
}


fetchInt { res in
  switch res {
  case .success(let i):
    print(i)
  case .failure(let e):
    print(e.localizedDescription)
  }
}
