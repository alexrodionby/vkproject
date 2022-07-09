//
//  NewsFeedAPI.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.07.22.
//

import Foundation

class NewsFeedAPI {
    
    //2. Async API (URLSession)
    func fetchNewsfeed(offset: Int = 0) async throws -> ([Post], [Profile], [Group]) {
        
        var urlComponents = URLComponents() //ascii/percent-encoding
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        
        //URL
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId ?? 0)"),
            URLQueryItem(name: "filter", value: "post"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        //оператор раннего выхода
        //throw - return для ошибок
        guard let url = urlComponents.url else {
            throw AppError.urlNotCreated
        }
        
        print("newsfeed url = ", url)
        
        //URLRequest
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
            
            //   print(data.prettyJSON)
            
            let newsfeedResponse = try JSONDecoder().decode(NewsFeedJSON.self, from: data)
            let posts: [Post] = newsfeedResponse.response.items
            let profiles: [Profile] = newsfeedResponse.response.profiles
            let groups: [Group] = newsfeedResponse.response.groups
            return (posts, profiles, groups)
            
        } catch {
            print(error)
            throw error
        }
    }
}
