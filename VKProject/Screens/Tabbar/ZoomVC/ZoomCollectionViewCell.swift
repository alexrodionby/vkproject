//
//  ZoomCollectionViewCell.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 4.06.22.
//

import UIKit

class ZoomCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var zoomImage: UIImageView!
    @IBOutlet weak var zoomScrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.zoomScrollView.delegate = self
        self.zoomScrollView.minimumZoomScale = 1
        self.zoomScrollView.maximumZoomScale = 3
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomImage
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        zoomScrollView.zoomScale = 1
    }
}
