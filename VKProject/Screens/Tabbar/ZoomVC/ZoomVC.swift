//
//  ZoomVC.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 4.06.22.
//

import UIKit
import SDWebImage

class ZoomVC: UIViewController {
    
    @IBOutlet weak var zoomCollection: UICollectionView!
    
    var zoomPhotos: [PhotosModel2] = []
    var currentIndexPath: IndexPath!
    var tempIndexPath: IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(addTapped))
        
        zoomCollection.delegate = self
        zoomCollection.dataSource = self
        zoomCollection.register(UINib(nibName: "ZoomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ZoomCell")
        print("currentIndexPath = ", currentIndexPath as Any)
        
        zoomCollection.performBatchUpdates(nil) { result in
            self.zoomCollection.scrollToItem(at: self.currentIndexPath, at: .right, animated: false)
        }
        
        //   zoomCollection.scrollToItem(at: IndexPath(row: 20, section: 0), at: .centeredHorizontally, animated: true)
        //  zoomCollection.contentOffset = CGPoint(x: zoomCollection.bounds.width * 10, y: 0)
    }
    
    @objc func addTapped() {
        let items: [Any] = [URL(string: zoomPhotos[tempIndexPath.row].averagePhoto) ?? ""]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(avc, animated: true)
    }
    
}

extension ZoomVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return zoomPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZoomCell", for: indexPath) as! ZoomCollectionViewCell
        print("indexPath = ", indexPath)
        cell.zoomImage.sd_setImage(with: URL(string: zoomPhotos[indexPath.row].averagePhoto))
        tempIndexPath = indexPath
        return cell
    }
}

extension ZoomVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthForItem = collectionView.bounds.width
        let heightForItem = collectionView.bounds.height
        return CGSize(width: widthForItem, height: heightForItem)
    }
}

extension ZoomVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected")
        
    }
}


