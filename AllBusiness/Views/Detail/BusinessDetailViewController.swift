//
//  BusinessDetailViewController.swift
//  AllBusiness
//
//  Created by Muhammad Ikhsan on 19/02/22.
//

import Foundation
import UIKit
import Kingfisher
import MapKit

protocol BusinessDetailViewControllerDelegate: AnyObject {
    func businessDetailFindRoute(name: String, coordinates: CLLocationCoordinate2D)
    func businessDetailCallBusiness(phoneUrl: URL)
    func businessDetailOpenWebsite(url: URL)
}

class BusinessDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    
    @IBOutlet weak var openHoursTableView: UITableView!
    @IBOutlet weak var openHoursTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var openHoursErrorLabel: UILabel!
    @IBOutlet weak var openHoursLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var reviewsTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var reviewsErrorLabel: UILabel!
    @IBOutlet weak var reviewsLoadingIndicator: UIActivityIndicatorView!
    
    var delegate: BusinessDetailViewControllerDelegate?
    
    let business: Business
    let viewModel: BusinessDetailViewModel
    let reviewsViewModel: BusinessReviewsViewModel
    
    private var openHourAdapter: OpenHourAdapter?
    
    init(business: Business, viewModel: BusinessDetailViewModel, reviewsViewModel: BusinessReviewsViewModel) {
        self.business = business
        self.viewModel = viewModel
        self.reviewsViewModel = reviewsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindData()
    }
    
    func setupView() {
        imageView.contentMode = .scaleAspectFill
        
        mapView.isZoomEnabled = false
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        
        addressButton.setTitle("", for: .application)
        addressButton.addClick(on: self, action: #selector(addressButtonDidTapped))
        phoneButton.setTitle("", for: .application)
        phoneButton.addClick(on: self, action: #selector(phoneButtonDidTapped))
        websiteButton.setTitle("", for: .application)
        websiteButton.addClick(on: self, action: #selector(websiteButtonDidTapped))
        
        openHourAdapter = OpenHourAdapter(tableView: openHoursTableView, heightConstraint: openHoursTableHeightConstraint)
        openHoursErrorLabel.isHidden = true
        openHoursLoadingIndicator.hidesWhenStopped = true
        
        reviewsErrorLabel.isHidden = true
        reviewsLoadingIndicator.hidesWhenStopped = true
    }
    
    func bindData() {
        title = business.name
        imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: business.imageUrl)!))
        
        nameLabel.text = business.name
        ratingLabel.text = business.ratingDisplay
        categoriesLabel.text = business.categoriesDisplay
        addressLabel.text = business.addressDisplay
        phoneLabel.text = business.displayPhone
        websiteLabel.text = business.url
        
        mapView.camera = MKMapCamera(lookingAtCenter: business.coordinatesTransformed,
                                     fromDistance: CLLocationDistance(1000),
                                     pitch: 0,
                                     heading: CLLocationDirection(0))
        let annotation = MKPointAnnotation()
        annotation.coordinate = business.coordinatesTransformed
        annotation.title = business.name
        mapView.addAnnotation(annotation)
        
        viewModel.isLoading.bind { value in
            if (value) {
                self.openHoursLoadingIndicator.startAnimating()
            } else {
                self.openHoursLoadingIndicator.stopAnimating()
            }
        }
        
        viewModel.source.bind { value in
            guard value != nil else { return }
            self.bindOtherDetails(business: value.unsafelyUnwrapped)
        }
        
        viewModel.error.bind { value in
            self.openHoursErrorLabel.isHidden = value == nil
            self.openHoursErrorLabel.text = value?.message ?? ""
        }
        
        viewModel.getDetails()
    }
    
    func bindOtherDetails(business: Business) {
        if let hours = business.hoursTransformed {
            openHourAdapter?.setData(source: hours)
        }
    }
    
    @objc func addressButtonDidTapped() {
        self.delegate?.businessDetailFindRoute(name: business.name, coordinates: business.coordinatesTransformed)
    }
    
    @objc func phoneButtonDidTapped() {
        self.delegate?.businessDetailCallBusiness(phoneUrl: business.phoneUrl)
    }
    
    @objc func websiteButtonDidTapped() {
        self.delegate?.businessDetailOpenWebsite(url: business.urlFormatted)
    }
}
