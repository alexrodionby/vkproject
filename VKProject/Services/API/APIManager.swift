//
//  APIManager.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//

import Foundation

//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

final class APIManager {
    
    private init() {}
    static let shared = APIManager()    

    //MARK: - getFriends
    
    // Новый нетворкслой асинковский запрос на поиск групп
    func searchFriends(searchString: String) async throws -> [FriendModel]  {
        
        do {
            let response = try await API.request(endpoint: FriendsEndpoint.searchFriends(searchString: searchString), responseModel: FriendsItems.self)
 
            return response.items ?? []
        } catch {
            print(error)
            throw error
        }
    }
    
    // Обычный запрос с комплишеном
    func getFriends(offset: Int = 0, completion: @escaping (Result<[FriendModel], AppError>)->()) {
        
        var urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/friends.get"
            return urlComponents
        }()
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userId!)"),
          //  URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "fields", value: "online,city,photo_100"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            //print(data.prettyJSON as Any)
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: data)
                let friends: [FriendModel] = friendsResponse.response?.items ?? []
                DispatchQueue.main.async {
                    completion(.success(friends))
                }
            } catch {
                print(error)
                completion(.failure(AppError.mappingError))
            }
        }
        session.resume()
    }
    
    //MARK: - getPhotos
    
    func getPhotos(offset: Int = 0, completion: @escaping ([PhotosModel2])->()) {
        
        var urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/photos.getAll"
            return urlComponents
        }()
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userId!)"),
            URLQueryItem(name: "extended", value: "0"),
            URLQueryItem(name: "count", value: "30"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "need_hidden", value: "0"),
            URLQueryItem(name: "skip_hidden", value: "1"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            //print(data.prettyJSON as Any)
            do {
                let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                let photos: [PhotosModel2] = photosResponse.response?.items ?? []
                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
    
    //MARK: - getUser
    
    func getUser(completion: @escaping ([UserModel])->()) {
        
        var urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/users.get"
            return urlComponents
        }()
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(Session.shared.userId!)"),
            URLQueryItem(name: "fields", value: "about,bdate,city,country,photo_200,online,photo_id"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            //print(data.prettyJSON as Any)
            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                let users: [UserModel] = userResponse.response ?? []
                DispatchQueue.main.async {
                    completion(users)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
    
    //MARK: - getGroups
    
    func getGroups(completion: @escaping ([GroupDAO])->()) {
        
        var urlComponents: URLComponents = {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "api.vk.com"
            urlComponents.path = "/method/groups.get"
            return urlComponents
        }()
        
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(Session.shared.userId!)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "city,country,description,members_count,site"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            print(data.prettyJSON as Any)
            do {
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                let groups: [GroupDAO] = groupsResponse.response?.items ?? []
                DispatchQueue.main.async {
                    print("на комплишене groups = ", groups)
                    completion(groups)
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }
    
    // Новый нетворкслой асинковский запрос на вывод групп
    func fetchGroups(offset: Int = 0) async throws -> [GroupDAO]  {
        
        do {
            let response = try await API.request(endpoint: GroupsEndpoint.fetchGroups(offset: offset), responseModel: GroupsItem.self)
 
            return response.items ?? []
        } catch {
            print(error)
            throw error
        }
    }
    
    // Новый нетворкслой асинковский запрос на поиск групп
    func searchGroups(searchString: String) async throws -> [GroupDAO]  {
        
        do {
            let response = try await API.request(endpoint: GroupsEndpoint.searchGroups(searchString: searchString), responseModel: GroupsItem.self)
 
            return response.items ?? []
        } catch {
            print(error)
            throw error
        }
    }
}
//MARK: - END
