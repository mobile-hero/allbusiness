//
//  BusinessFilterViewController.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 22/02/22.
//

import Foundation
import UIKit

protocol BusinessFilterViewControllerDelegate: AnyObject {
    func businessFilterDidClosed()
    func businessFilterSelectLocation()
}

class BusinessFilterViewController: UIViewController {
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var sortByControl: UISegmentedControl!
    
    var delegate: BusinessFilterViewControllerDelegate?
    
    var businessListViewModel: BusinessListViewModel?
    
    init(businessListViewModel: BusinessListViewModel) {
        self.businessListViewModel = businessListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Filter"
        view.backgroundColor = .background
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                                            target: self,
                                                            action: #selector(closeDidTapped))
        
        locationField.delegate = self
        
        sortByControl.addOnValueChanged(on: self, action: #selector(sortByControlValueChanged))
    }
    
    @objc func sortByControlValueChanged(_ control: UISegmentedControl) {
        let index = control.selectedSegmentIndex
        let title = control.titleForSegment(at: index)!.lowercased()
        print(title)
        businessListViewModel?.sortBy = title
    }
    
    @objc func closeDidTapped() {
        self.dismiss(animated: true) {
            self.delegate?.businessFilterDidClosed()
        }
    }
}

extension BusinessFilterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.delegate?.businessFilterSelectLocation()
        return false
    }
}
