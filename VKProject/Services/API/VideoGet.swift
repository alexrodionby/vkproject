//
//  VideoGet.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 19.07.22.
//

import Foundation

//MARK: - Async Recuest getFriendsAsync
class AsyncVideoAPI {
    
    func getVideoAsync(offset: Int = 0) async throws -> [VideoModel] {
        var urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/video.get"
            return urlComponents
        }()
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "-63758929"),
         //   URLQueryItem(name: "user_id", value: "2056199"),
            URLQueryItem(name: "count", value: "50"),
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
      //      print(data.prettyJSON as Any)
            let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
            let video: [VideoModel] = videoResponse.response?.items ?? []
            return video
            
        } catch {
            print(error)
            throw error
        }
    }
}
