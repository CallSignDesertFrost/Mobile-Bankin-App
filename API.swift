import Foundation

struct API {
    static let baseURL = "http://localhost:3000"
    
    static func register(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // Implement registration API call
    }
    
    static func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // Implement login API call
    }
    
    static func getUser(id: String, completion: @escaping (Result<User, Error>) -> Void) {
        // Implement get user API call
    }
    
    static func transfer(from: String, to: String, amount: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        // Implement transfer API call
    }
    
    static func deposit(userId: String, amount: Double, completion: @escaping (Result<Void, Error>) -> Void) {
        // Implement deposit API call
    }
}

static func register(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    let url = URL(string: "\(baseURL)/register")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: Any] = ["username": username, "password": password]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completion(.failure(NSError(domain: "Register Error", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data!)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}

static func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    let url = URL(string: "\(baseURL)/login")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: Any] = ["username": username, "password": password]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            completion(.failure(NSError(domain: "Login Error", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: