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
    
    func getFollowers(for username: String, page number: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint =  "\(baseUrl)users/\(username)/followers?page=\(number)&per_page=100"
        
        guard let url = URL(string: endpoint) else {
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
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
    }
}
