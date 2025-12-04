//
//  APIService.swift
//  github_task
//
//  Created by Yash Rathod on 12/4/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func request(url:String, method: String = "GET", completion : @escaping(Result<GitHubUser, Error>) -> Void) {
        guard let url = URL(string:(url)) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else { return }
            
            guard let httpResponse = response as? HTTPURLResponse else {
               let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
               completion(.failure(err))
               return
            }
            print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
            
            do {
                if(httpResponse.statusCode == 200) {
                    let result = try JSONDecoder().decode(GitHubUser.self, from: data)
                    completion(.success(result))
                } else if(httpResponse.statusCode == 404){
                    let err = NSError(
                       domain: "",
                       code: httpResponse.statusCode,
                       userInfo: [NSLocalizedDescriptionKey: "User Not Found"]
                   )
                   completion(.failure(err))
                }
                
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}
