//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 10/11/1445 AH.
//

import UIKit


struct NetworkManager {
    private let decoder: JSONDecoder
    private let baseUrl = "https://api.github.com/"
    let cache = NSCache<NSString, UIImage>()
    private init(){
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    static let shared = NetworkManager()
    
    private func getData<T: Decodable>(type: T.Type, for urlString: String, completed: @escaping (Result<T, GFError>) -> Void){
        guard let url = URL(string: urlString) else {
                    completed(.failure(.invalidUsername))
                    return
                }
                
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    if let _ = error {
                        completed(.failure(.unableToComplete))
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completed(.failure(.invalidResponse))
                        return
                    }
                    
                    guard let data = data else {
                        completed(.failure(.invalidData))
                        return
                    }
                    
                    do {
                        let data = try decoder.decode(T.self, from: data)
                        completed(.success(data))
                    } catch {
                        print(error)
                        completed(.failure(.invalidData))
                        return
                    }
                }
                
                task.resume()
    }
    
    
    func getFollowers(for username: String, page number: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint =  "\(baseUrl)users/\(username)/followers?page=\(number)&per_page=100"
        getData(type: [Follower].self, for: endpoint, completed: completed)
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void){
        let endpoint = "\(baseUrl)users/\(username)"
        getData(type: User.self, for: endpoint, completed: completed)
    }
    
    
}
