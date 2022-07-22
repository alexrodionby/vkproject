//
//  VideoVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 19.07.22.
//

import UIKit

class VideoVC: UIViewController {
    
    var videos: [VideoModel] = []
    var getVideoApi = AsyncVideoAPI()
    
    private lazy var videoTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        asyncFetchVideos(offset: 0)
    }
    
    private func asyncFetchVideos(offset: Int) {
        Task {
            do {
                let videos = try await getVideoApi.getVideoAsync(offset: offset)
                self.videos = videos
                self.videoTableView.reloadData()
            } catch {
                self.showErrorAlert(title: "", message: error.localizedDescription)
            }
        }
    }
    
    private func setupView() {
        view.addSubview(videoTableView)
        videoTableView.frame = view.frame
    }
}

extension VideoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as! VideoCell
        let video = videos[indexPath.row]
        cell.configure(video)
        return cell
    }
}

extension VideoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
}






















//
//
//
//
//
//
//
//class VideoVC: UIViewController {
//
//    let videoTableView = UITableView()
//
//    var videos: [VideoModel] = []
//    var getVideoApi = AsyncVideoAPI()
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
//        tableView.dataSource = self //Отвечает за данные
//        tableView.delegate = self //Отвечает за поведение
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(videoTableView)
//        //videoTableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
//        videoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        videoTableView.delegate = self
//        videoTableView.dataSource = self
//        asyncFetchVideos(offset: 0)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        videoTableView.frame = view.bounds
//    }
//
//    private func asyncFetchVideos(offset: Int) {
//        Task {
//            do {
//                let videos = try await getVideoApi.getVideoAsync(offset: offset)
//                self.videos = videos
//                self.videoTableView.reloadData()
//            } catch {
//                self.showErrorAlert(title: "", message: error.localizedDescription)
//            }
//        }
//    }
//}
//
//extension VideoVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return videos.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let webView = WKWebView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 300)))
//
//
//        cell.addSubview(webView)
//        cell.frame = webView.frame
//        webView.load(URLRequest(url: URL(string: videos[indexPath.row].player!)!))
//        //        cell.configure(name: videos[indexPath.row].titleVideo!, likes: (videos[indexPath.row].likes?.count)!, views: videos[indexPath.row].views!, videoPath: videos[indexPath.row].player!)
//        //        VideoCell.urlVideo = videos[indexPath.row].player!
//        //        print("path", videos[indexPath.row].player!)
//
//        return cell
//    }
//}
