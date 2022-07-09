//
//  PhotosViewCell.swift
//  VKProject
//
//  Created by Alexandr Rodionov on 28.05.22.
//

import UIKit


class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoInCell: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 9
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        self.clipsToBounds = false
    }
}
