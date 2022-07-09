//
//  NewsFeedVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 8.07.22.
//

import UIKit

//1 секция = 1 новости
//1 новости = 1 автор, 1 текст, 1 фото, 1 лайки

enum NewsFeedCellType: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likes
}

final class NewsFeedVC: UIViewController {
    
    var posts: [Post] = []
    var profiles: [Profile] = []
    var groups: [Group] = []
    
    let newsfeedAPI = NewsFeedAPI()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        
        tableView.register(PostAuthorCell.self, forCellReuseIdentifier: PostAuthorCell.identifier)
        tableView.register(PostTextCell.self, forCellReuseIdentifier: PostTextCell.identifier)
        tableView.register(PostPhotoCell.self, forCellReuseIdentifier: PostPhotoCell.identifier)
        tableView.register(PostLikesCell.self, forCellReuseIdentifier: PostLikesCell.identifier)
        
        tableView.dataSource = self //Отвечает за данные
        tableView.delegate = self //Отвечает за поведение
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        Task {
            do {
                let (posts, profiles, groups) = try await newsfeedAPI.fetchNewsfeed()
                self.posts = posts
                self.profiles = profiles
                self.groups = groups
                self.tableView.reloadData()
                
                print(posts)
            } catch {
                print(error)
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
}

extension NewsFeedVC: UITableViewDelegate {
    // Нечего делегировать
}

extension NewsFeedVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsFeedCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let cellType = NewsFeedCellType(rawValue: indexPath.row) else { return 0 }
        let post = posts[indexPath.section]
        
        switch cellType {
            
        case .text:
            if let text = post.text, text.isEmpty {
                return 0
            }
            if post.text == nil {
                return 0
            }
            
        case .photo:
            if post.photos?.items.first?.sizes.first == nil {
                return 0
            }
            
        default:
            return UITableView.automaticDimension
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = NewsFeedCellType(rawValue: indexPath.row)
        
        switch cellType {
            
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostAuthorCell.identifier, for: indexPath) as! PostAuthorCell
            let post = posts[indexPath.section]
            
            if post.sourceID > 0 {
                if let profile = profiles.first(where: { $0.id == post.sourceID }) {
                    cell.configure(profile)
                }
            }
            
            if post.sourceID < 0 {
                if let group = groups.first(where: { $0.id == abs(post.sourceID) }) {
                    cell.configure(group)
                }
            }
            
            return cell
            
        case .text:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTextCell.identifier, for: indexPath) as! PostTextCell
            let post = posts[indexPath.section]
            cell.configure(post)
            return cell
            
        case .photo:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PostPhotoCell.identifier, for: indexPath) as! PostPhotoCell
            let post = posts[indexPath.section]
            cell.configure(post)
            return cell
            
        case .likes:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PostLikesCell.identifier, for: indexPath) as! PostLikesCell
            let post = posts[indexPath.section]
            cell.configure(post)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

