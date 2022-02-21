//
//  ReviewCell.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation
import UIKit

class ReviewCell: UITableViewCell {
 
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func bind(data: Review) {
        userLabel.text = data.user.name
        ratingLabel.text = data.rating.description
        commentLabel.text = data.text
    }
}
