//
//  OpenHourCell.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 21/02/22.
//

import Foundation
import UIKit

class OpenHourCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    func bind(data: OpenHourData) {
        dayLabel.text = data.day
        hourLabel.text = data.hours
    }
}
