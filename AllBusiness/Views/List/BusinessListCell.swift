//
//  BusinessListCell.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 10/02/22.
//

import Foundation
import UIKit
import Kingfisher

class BusinessListCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func bind(_ imageUrl: String) {
        guard !imageUrl.isEmpty else {
            image.image = UIImage(named: "warning")
            return
        }
        let url = URL(string: imageUrl)!
        image.kf.setImage(with: .network(ImageResource(downloadURL: url)))
        image.contentMode = .scaleAspectFill
    }
}
