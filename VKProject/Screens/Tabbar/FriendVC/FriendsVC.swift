//
//  FriendsVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 27.05.22.
//

import UIKit
import SDWebImage

class FriendsVC: UIViewController {
    
    @IBOutlet weak var friendsTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendsVM = FriendsViewModel()
    var friendsV = FriendsView()
    var getFriendsApi = AsyncFriendsAPI()
    
    //    private lazy var refreshControl: UIRefreshControl = {
    //        let refreshControl = UIRefreshControl()
    //        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
    //        return refreshControl
    //    }()
    
    //  @objc func pullToRefreshAction() {
    //    friendsV.onPullToRefreshAction = {
    //        friendsV.refreshControl.beginRefreshing()
    //        APIManager.shared.getFriends(offset: 0) { result in
    //            switch result {
    //            case .success (let friends):
    //                self.friendsVM.friends = friends
    //                DispatchQueue.main.async {
    //                    self.friendsTable.reloadData()
    //                }
    //                self.friendsV.refreshControl.endRefreshing()
    //            case .failure (let error):
    //                self.showErrorAlert(title: error.description, message: "")
    //                self.friendsVM.friends = []
    //                self.friendsV.refreshControl.endRefreshing()
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Скрываем клавиатуру по тапу в пустом месте
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        // Это новый асинхронный запрос
        // не забываем закончить рефрэш
        friendsV.onPullToRefreshAction = {
            self.friendsV.refreshControl.beginRefreshing()
            
            //self.asyncFetchFriends(offset: 0)
            //Вместо обычного запроса пробуем асинковский из нетворк слоя
            
            Task {
                do {
                    self.friendsVM.friends = try await self.fetchFriends()
                    self.friendsTable.reloadData()
                } catch {
                    self.showErrorAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
            
            // релоадить при асинке тогда не надо, это сделано выше
            //  self.friendsTable.reloadData()
            self.friendsV.refreshControl.endRefreshing()
        }
        // Ниже старый обычный запрос
        
        //            APIManager.shared.getFriends(offset: 0) { result in
        //                switch result {
        //                case .success (let friends):
        //                    self.friendsVM.friends = friends
        //                    DispatchQueue.main.async {
        //                        self.friendsTable.reloadData()
        //                    }
        //                    self.friendsV.refreshControl.endRefreshing()
        //                case .failure (let error):
        //                    self.showErrorAlert(title: error.description, message: "")
        //                    self.friendsVM.friends = []
        //                    self.friendsV.refreshControl.endRefreshing()
        //                }
        //            }
        
        
        friendsTable.refreshControl = friendsV.refreshControl
        // Новый запрос из нетвор слой через колбэк
        fetchFriends { friends in
            self.friendsVM.friends = friends
            self.friendsTable.reloadData()
        } failure: { error in
            self.showErrorAlert(title: "Ошибка", message: error.localizedDescription)
        }
        
        // Старый асинхронный запрос
        // asyncFetchFriends(offset: 0)
        
        // Ниже старый обычный запрос
        //        APIManager.shared.getFriends { [weak self] friends in
        //            guard let self = self else { return }
        //            self.friends = friends
        //            DispatchQueue.main.async {
        //                self.friendsTable.reloadData()
        //            }
        //        }
        
        
        //MARK: - Ниже код старого обычного запроса через колбэк
        
        //        APIManager.shared.getFriends(offset: 0) { result in
        //            switch result {
        //            case .success (let friends):
        //                self.friendsVM.friends = friends
        //                DispatchQueue.main.async {
        //                    self.friendsTable.reloadData()
        //                }
        //            case .failure (let error):
        //                self.showErrorAlert(title: error.description, message: "")
        //                self.friendsVM.friends = []
        //            }
        //        }
    }
    
    //MARK: - Асинхронный запрос из нетвор слоя
    
    func fetchFriends(offset: Int = 0) async throws -> [FriendModel]  {
        
        do {
            let friendsItems:FriendsItems = try await API.request(endpoint: FriendsEndpoint.fetchFriends(offset: offset), responseModel: FriendsItems.self)
            
            return friendsItems.items!
        } catch {
            print(error)
            throw error
        }
    }
    
    //MARK: - Новый запрос из нетворк слоя
    
    func fetchFriends(offset: Int = 0, success: @escaping ([FriendModel])->(), failure: @escaping(Error)->()) {
        
        API.request(endpoint: FriendsEndpoint.fetchFriends(offset: offset)) { (result: Result<FriendsItems, Error>) in
            
            switch result {
            case .success(let friendsItems):
                let friends = friendsItems.items
                success(friends!)
                
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //MARK: - Используем новый асинхронный запрос
    
    private func asyncFetchFriends(offset: Int) {
        Task {
            do {
                let friends = try await getFriendsApi.getFriendsAsync(offset: offset)
                self.friendsVM.friends = friends
                self.friendsTable.reloadData()
            } catch {
                self.showErrorAlert(title: "", message: error.localizedDescription)
            }
        }
    }
}

extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(friendsVM.friends.count)
        return friendsVM.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendTableViewCell
        
        cell.friendName.text = String(friendsVM.friends[indexPath.row].firstName ?? "") + " " + String(friendsVM.friends[indexPath.row].lastName ?? "")
        if friendsVM.friends[indexPath.row].photo100 == nil {
            cell.friendImage.image = UIImage(systemName: "person")
        } else {
            cell.friendImage.sd_setImage(with: URL(string: friendsVM.friends[indexPath.row].photo100 ?? ""))
        }
        cell.friendImage.layer.cornerRadius = 10
        cell.friendImage.layer.shadowRadius = 10
        cell.friendImage.layer.shadowOpacity = 0.5
        cell.friendImage.layer.shadowOffset = CGSize(width: 5, height: 8)
        cell.friendImage.clipsToBounds = false
        cell.friendCity.text = String(friendsVM.friends[indexPath.row].city?.title ?? "")
        if friendsVM.friends[indexPath.row].online == 1 || friendsVM.friends[indexPath.row].onlineMobile == 1 || friendsVM.friends[indexPath.row].onlineApp == 1 {
            cell.friendOnline.text = "Online"
            cell.friendOnline.textColor = .blue
        } else {
            cell.friendOnline.text = "Offline"
            cell.friendOnline.textColor = .darkGray
        }
        
        return cell
    }
}

extension FriendsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            Task {
                do {
                    self.friendsVM.friends = try await self.fetchFriends()
                    self.friendsTable.reloadData()
                } catch {
                    self.showErrorAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        } else {
            print("Вводим текст =", searchText)
            Task {
                do {
                    self.friendsVM.friends = try await APIManager.shared.searchFriends(searchString: searchText)
                    self.friendsTable.reloadData()
                } catch {
                    self.showErrorAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }
}
