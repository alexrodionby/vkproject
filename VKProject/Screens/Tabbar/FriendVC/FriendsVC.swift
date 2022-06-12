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
    
    var friends: [FriendModel] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        APIManager.shared.getFriends(offset: 0) { result in
            switch result {
            case .success (let friends):
                self.friends = friends
                DispatchQueue.main.async {
                    self.friendsTable.reloadData()
                }
                self.refreshControl.endRefreshing()
            case .failure (let error):
                self.showErrorAlert(title: error.description, message: "")
                self.friends = []
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTable.refreshControl = refreshControl
        
        //        APIManager.shared.getFriends { [weak self] friends in
        //            guard let self = self else { return }
        //            self.friends = friends
        //            DispatchQueue.main.async {
        //                self.friendsTable.reloadData()
        //            }
        //        }
        
        APIManager.shared.getFriends(offset: 0) { result in
            switch result {
            case .success (let friends):
                self.friends = friends
                DispatchQueue.main.async {
                    self.friendsTable.reloadData()
                }
            case .failure (let error):
                self.showErrorAlert(title: error.description, message: "")
                self.friends = []
            }
        }
    }
}


extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(friends.count)
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendTableViewCell
        
        cell.friendName.text = String(friends[indexPath.row].firstName ?? "") + " " + String( friends[indexPath.row].lastName ?? "")
        cell.friendImage.sd_setImage(with: URL(string: friends[indexPath.row].photo100 ?? ""))
        cell.friendImage.layer.cornerRadius = 10
        cell.friendImage.layer.shadowRadius = 10
        cell.friendImage.layer.shadowOpacity = 0.5
        cell.friendImage.layer.shadowOffset = CGSize(width: 5, height: 8)
        cell.friendImage.clipsToBounds = false
        cell.friendCity.text = String(friends[indexPath.row].city?.title ?? "")
        if friends[indexPath.row].online == 1 || friends[indexPath.row].onlineMobile == 1 || friends[indexPath.row].onlineApp == 1 {
            cell.friendOnline.text = "Online"
            cell.friendOnline.textColor = .blue
        } else {
            cell.friendOnline.text = "Offline"
            cell.friendOnline.textColor = .darkGray
        }
        
        return cell
    }
    
    
    
    
}
