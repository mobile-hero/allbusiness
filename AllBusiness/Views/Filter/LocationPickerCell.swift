//
//  LocationPickerCell.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 22/02/22.
//

import Foundation
import UIKit

class LocationPickerCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func bind(data: String) {
        nameLabel.text = data
    }
}
