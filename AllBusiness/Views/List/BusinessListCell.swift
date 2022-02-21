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
    @IBOutlet weak var nameLabel: UILabel!
    
    func bind(_ imageUrl: String, name: String) {
        if !imageUrl.isEmpty, let url = URL(string: imageUrl) {
            image.kf.setImage(with: .network(ImageResource(downloadURL: url)))
            image.contentMode = .scaleAspectFill
        } else {
            image.image = UIImage(named: "warning")
        }
        
        nameLabel.text = name
    }
}
