import Foundation

enum Link {
    case employees
    
    var url: URL {
        switch self {
        case .employees:
            return URL(string: "https://dummy.restapiexample.com//api/v1/employees")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case tooManyRequests
    case decodingError
}

final class NetworkManager: ObservableObject {
    init() {
        
    }
    
    static let shared = NetworkManager()
    
    func fetchEmplyees(completion: @escaping (Result<[Employee], NetworkError>) -> Void) {
        print("Try to fetch")
        
        let fetchRequest = URLRequest(url: Link.employees.url)
        
        URLSession.shared.dataTask(with: fetchRequest) { (data, response, error) -> Void in
            if error != nil {
                print("ERROR in session is not nil")
                completion(.failure(.noData))
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("status code: \(httpResponse?.statusCode)")
                
                if httpResponse?.statusCode == 429 {
                    completion(.failure(.tooManyRequests))
                } else {
                    guard let safeData = data else { return }
                    
                    do {
                        let decodedQuery = try JSONDecoder().decode(Query.self, from: safeData)
                        
                        completion(.success(decodedQuery.data))
                    } catch let decodeError {
                        print("Decoding error: \(decodeError)")
                        completion(.failure(.decodingError))
                    }
                }
            }
        }.resume()
    }
}
