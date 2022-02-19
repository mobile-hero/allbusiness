//
//  BusinessDetailViewController.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import UIKit

class BusinessDetailViewController: UIViewController {
    
    let business: Business
    
    init(business: Business) {
        self.business = business
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
