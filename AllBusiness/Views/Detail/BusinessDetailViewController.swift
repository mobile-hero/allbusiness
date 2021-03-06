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
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var photosErrorLabel: UILabel!
    @IBOutlet weak var photosLoadingIndicator: UIActivityIndicatorView!
    
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
    
    private var photoAdapter: PhotoAdapter?
    private var openHourAdapter: OpenHourAdapter?
    private var reviewAdapter: ReviewAdapter?
    
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
        
        addressButton.setImage(UIImage(named: "turn-direction"), for: .normal)
        addressButton.setTitle("", for: .normal)
        addressButton.addClick(on: self, action: #selector(addressButtonDidTapped))
        phoneButton.setImage(UIImage(named: "phone"), for: .normal)
        phoneButton.setTitle("", for: .normal)
        phoneButton.addClick(on: self, action: #selector(phoneButtonDidTapped))
        websiteButton.setImage(UIImage(named: "share"), for: .normal)
        websiteButton.setTitle("", for: .normal)
        websiteButton.addClick(on: self, action: #selector(websiteButtonDidTapped))
        
        photoAdapter = PhotoAdapter(collectionView: photosCollectionView)
        photosErrorLabel.isHidden = true
        photosLoadingIndicator.hidesWhenStopped = true
        
        openHourAdapter = OpenHourAdapter(tableView: openHoursTableView, heightConstraint: openHoursTableHeightConstraint)
        openHoursErrorLabel.isHidden = true
        openHoursLoadingIndicator.hidesWhenStopped = true
        
        reviewAdapter = ReviewAdapter(tableView: reviewsTableView, heightConstraint: reviewsTableHeightConstraint)
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
                self.photosLoadingIndicator.startAnimating()
            } else {
                self.openHoursLoadingIndicator.stopAnimating()
                self.photosLoadingIndicator.stopAnimating()
            }
        }
        
        viewModel.source.bind { value in
            guard value != nil else { return }
            self.bindOtherDetails(business: value.unsafelyUnwrapped)
        }
        
        viewModel.error.bind { value in
            self.photosErrorLabel.isHidden = value == nil
            self.photosErrorLabel.text = value?.message ?? ""
            self.openHoursErrorLabel.isHidden = value == nil
            self.openHoursErrorLabel.text = value?.message ?? ""
        }
        
        reviewsViewModel.isLoading.bind { value in
            if (value) {
                self.reviewsLoadingIndicator.startAnimating()
            } else {
                self.reviewsLoadingIndicator.stopAnimating()
            }
        }
        
        reviewsViewModel.source.bind { value in
            self.bindReviews(reviews: value)
        }
        
        reviewsViewModel.error.bind { value in
            self.reviewsErrorLabel.isHidden = value == nil
            self.reviewsErrorLabel.text = value?.message ?? ""
        }
        
        viewModel.getDetails()
        reviewsViewModel.getReviews()
    }
    
    func bindOtherDetails(business: Business) {
        if let photo = business.photos {
            photoAdapter?.setData(source: photo)
        }
        if let hours = business.hoursTransformed {
            openHourAdapter?.setData(source: hours)
        }
    }
    
    func bindReviews(reviews: [Review]) {
        reviewAdapter?.setData(source: reviews)
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
