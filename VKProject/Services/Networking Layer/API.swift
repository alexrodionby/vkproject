//
//  API.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 22.07.22.
//

import Foundation

class API {
    
    class func request<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        
        //1. URL
        var urlComponents = URLComponents() //ascii/percent-encoding
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.baseUrl
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        guard let url = urlComponents.url else {
            throw AppError.urlNotCreated
        }
        
        print(url)
        
        //2. URLRequest (HTTP Request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        print(urlRequest)
        
        do {
            let session = URLSession(configuration: .default)
            let (data, response) = try await session.data(for: urlRequest)

            print(data.prettyJSON as Any)

            
            if let response = response as? HTTPURLResponse {
                
                switch response.statusCode {
                case 200..<300: break
                case 400..<500:
                    //return completion(.failure(AppError.client))
                    throw AppError.clientError
                case 500..<600:
                    //return completion(.failure(AppError.server))
                    throw AppError.serverError
                default:
                    //return completion(.failure(AppError.unknownStatusCode))
                    throw AppError.unknownStatusCode
                }
            }
            
            let responseJson = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            let responseObject = responseJson.response
            print(responseObject)
    
            return responseObject
            
        } catch {
            print(error)
            throw error
        }
        
    }
    
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) {
        
        //1. URL
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.baseUrl
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.parameters
        guard let url = urlComponents.url else { return }
        
        print(url)
        
        //2. URLRequest (HTTP Request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        print(urlRequest)
        
        //3. URLSession
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                return completion(.failure(error))
            }
            
            print(data?.prettyJSON as Any)
            
            guard let data = data else {
                return completion(.failure(AppError.mappingError))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300: break
                case 400..<500:
                    return completion(.failure(AppError.clientError))
                case 500..<600:
                    return completion(.failure(AppError.serverError))
                default:
                    return completion(.failure(AppError.unknownStatusCode))
                }
            }
            
            do {
                let responseJson = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
                let responseObject = responseJson.response
                
                print(responseObject)
                
                DispatchQueue.main.async {
                    print(Thread.current)
                    completion(.success(responseObject))
                }
                
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}
