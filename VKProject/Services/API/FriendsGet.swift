//
//  FriendsGet.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 5.07.22.
//

import Foundation

//MARK: - Async Recuest getFriendsAsync
class AsyncAPI {
    
    func getFriendsAsync(offset: Int = 0) async throws -> [FriendModel] {
        var urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/friends.get"
            return urlComponents
        }()
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId!)"),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "fields", value: "online,city,photo_100"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else {
            throw AppError.urlNotCreated
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200..<300: break
                case 400..<500:
                    throw AppError.clientError
                case 500..<600:
                    throw AppError.serverError
                default:
                    throw AppError.unknownStatusCode
                }
            }
            
            let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: data)
            let friends: [FriendModel] = friendsResponse.response?.items ?? []
            return friends
            
        } catch {
            print(error)
            throw error
        }
    }
}
