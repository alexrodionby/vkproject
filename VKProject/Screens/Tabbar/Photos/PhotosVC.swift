//
//  PhotosVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 28.05.22.
//

import UIKit
import SDWebImage

class PhotosVC: UIViewController {
    
    @IBOutlet weak var photosCollection: UICollectionView!
    
    var photos: [PhotosModel2] = []
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollection.prefetchDataSource = self
        photosCollection.isPrefetchingEnabled = true
        photosCollection.refreshControl = refreshControl
        
        APIManager.shared.getPhotos { [weak self] photos in
            guard let self = self else { return }
            self.photos = photos
            DispatchQueue.main.async {
                self.photosCollection.reloadData()
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        APIManager.shared.getPhotos { [weak self] photos in
            guard let self = self else { return }
            self.photos = photos
            DispatchQueue.main.async {
                self.photosCollection.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }
}

extension PhotosVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotosCollectionViewCell
        cell.photoInCell.sd_setImage(with: URL(string: photos[indexPath.row].averagePhoto))
        
        return cell
    }
}

extension PhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let inset = 10 // Задаем некий стандартный отступ
        let itemsInRow = 3 // Кол-во элементов в строчку
        let insetsWidth = inset * (itemsInRow + 1) // ширина отступов всех
        let availableWith = collectionView.bounds.width - CGFloat(insetsWidth) // Оставшееся полезное место на итемы
        let widthForItem = availableWith / CGFloat(itemsInRow) // размер места для одного итема
        return CGSize(width: widthForItem, height: widthForItem) // размер ячейки.
    }
    // Задаем отступы для всей секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // отступы от секции
    }
}

extension PhotosVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected")
        let zoomVC = storyboard?.instantiateViewController(withIdentifier: "ZoomVC") as! ZoomVC
        self.navigationController?.pushViewController(zoomVC, animated: true)
        zoomVC.zoomPhotos = photos
        zoomVC.currentIndexPath = indexPath
    }
}

extension PhotosVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        guard let maxRow = indexPaths.map({ $0.row }).max() else { return }
        if maxRow > photos.count - 5 {
            print("пришли вниз таблицы")
            if isLoading == false {
                isLoading = true //Ставим защиту не пускаем запрос на выполение пока выполняется запрос
                APIManager.shared.getPhotos(offset: photos.count) { [weak self] photos in
                    guard let self = self else { return }
                    self.isLoading = false
                    self.photos.append(contentsOf: photos)
                    DispatchQueue.main.async {
                        self.photosCollection.reloadData()
                    }
                }
            }
        }
    }
}


