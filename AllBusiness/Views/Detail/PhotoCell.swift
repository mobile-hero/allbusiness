//
//  PokemonListCell.swift
//  PokemonLibrary
//
//  Created by Muhammad Ikhsan on 10/02/22.
//

import Foundation
import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    func bind(_ imageUrl: String) {
        let url = URL(string: imageUrl)!
        image.kf.setImage(with: .network(ImageResource(downloadURL: url)))
        image.contentMode = .scaleAspectFill
    }
}
