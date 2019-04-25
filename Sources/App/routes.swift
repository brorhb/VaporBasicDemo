import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // Slightly more advanced hello world http://localhost:8080/hello/vapor
    router.get("hello", "vapor") { req -> String in
        return "Hello Vapor!"
    }
    
    // Slightly more advanced hello world with string param http://localhost:8080/hello/YourParamHere
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "Hello \(name)"
    }
    
    // basic post request, returns JSON
    router.post(InfoData.self, at: "info") {req, data -> InfoResponse in
        return InfoResponse(request: data)
    }
    
    // Challenge time
    router.get("date") {req -> String in
        let date = Date.init()
        return "\(date)"
    }
    
    router.get("counter", Int.parameter) { req -> Count in
        let number = try req.parameters.next(Int.self)
        return Count(number: number)
    }
    
    router.post(UserInfo.self, at: "user-info") { req, data -> String in
        return "Hello \(data.name), you are \(data.age)"
    }
}

struct Count: Content {
    let number: Int
}

struct UserInfo: Content {
    let name: String
    let age: Int
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}
