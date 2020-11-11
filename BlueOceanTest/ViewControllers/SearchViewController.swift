//
//  SearchViewController.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var imageInfoPanel: UIView!
    @IBOutlet weak var imageInfo: UILabel!
    @IBOutlet weak var orderPanel: UIView!
    @IBOutlet weak var colorPanel: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var relevanceOrderButton: UIButton!
    @IBOutlet weak var anyColorButton: UIButton!
    @IBOutlet weak var searchedWordLabel: UILabel!
    @IBOutlet weak var toast: Toast!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var searchedWord: String!
    
    private var currentPage = 1
    private var currentOrderBy = UnsplashAPI.OrderByForSearchPhotos.relevant
    private var currentColor = UnsplashAPI.Color.any
    private var currentOrderButton: UIButton!
    private var currentColorButton: UIButton!
    private var noMoreImages = false
    
    private let unsplashPhotoViewModel = UnsplashPhotoViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchedWordLabel.text = searchedWord!
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "CollectionViewCellForUnsplashImage", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellForUnsplashImage")
        
        indicatorView.startAnimating()
        unsplashPhotoViewModel.fetchUnsplashSearchPhotos(query: searchedWord, page: String(currentPage), perPage: .maximum, orderBy: currentOrderBy, color: currentColor, orientation: .portrait)  { [self] (result) -> () in
            DispatchQueue.main.async {
                unsplashPhotoViewModel.setListOfPhotos(list: result)
                self.updateUI(scrollToTop: true)
            }
        }
        
        currentOrderButton = relevanceOrderButton
        currentColorButton = anyColorButton
    }
    
    private func updateUI(scrollToTop: Bool) {
        collectionView.reloadData()
        if scrollToTop {
            if unsplashPhotoViewModel.getNumOfPhotoModels() >= 1 {
                collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: false)
            } else {
                toast.show(text: "No images are available this time.")
            }
        }
        indicatorView.stopAnimating()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIApplication.shared.windows.first?.frame.width)! <= 375 {
            return CGSize.init(width: 110, height: 110)
        } else {
            return CGSize.init(width: 125, height: 125)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: self.view.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unsplashPhotoViewModel.getNumOfPhotoModels()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellForUnsplashImage", for: indexPath) as! CollectionViewCellForUnsplashImage
        unsplashPhotoViewModel.configureForSearchPhotos(collectionViewCell: cell, index: indexPath.row)
        
        if !noMoreImages && indexPath.row == unsplashPhotoViewModel.getNumOfPhotoModels() - 1 {
            currentPage += 1
            indicatorView.startAnimating()
            unsplashPhotoViewModel.fetchUnsplashSearchPhotos(query: searchedWord, page: String(currentPage), perPage: .maximum, orderBy: currentOrderBy, color: currentColor, orientation: .portrait)  { [self] (result) -> () in
                DispatchQueue.main.async {
                    if result.count == 0 {
                        noMoreImages = true
                    }
                    unsplashPhotoViewModel.appendListOfPhotos(list: result)
                    self.updateUI(scrollToTop: false)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PanelAnimationController.showPanel(panel: imageInfoPanel)
        
        unsplashPhotoViewModel.configureForImageInfo(label: imageInfo, index: indexPath.row)
    }
    
    @IBAction func onBackButtonClick(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onOrderByButtonClick(sender: UIButton) {
        var fetchPhotos = false
        let buttonTitle = sender.title(for: .normal)
        if buttonTitle == "Sort" {
            PanelAnimationController.showPanel(panel: orderPanel)
        } else if buttonTitle == "Relevance" {
            if currentOrderBy == .relevant {
                toast.show(text: "It is already sorted by Relevance.")
            } else {
                currentOrderBy = .relevant
                fetchPhotos = true
            }
        } else {
            if currentOrderBy == .latest {
                toast.show(text: "It is already sorted by Newest.")
            } else {
                currentOrderBy = .latest
                fetchPhotos = true
            }
        }
        if fetchPhotos {
            currentOrderButton.setTitleColor(UIColor.lightGray, for: .normal)
            sender.setTitleColor(UIColor.black, for: .normal)
            currentOrderButton = sender
            
            currentPage = 1
            indicatorView.startAnimating()
            noMoreImages = false
            unsplashPhotoViewModel.fetchUnsplashSearchPhotos(query: searchedWord, page: String(currentPage), perPage: .maximum, orderBy: currentOrderBy, color: currentColor, orientation: .portrait)  { [self] (result) -> () in
                DispatchQueue.main.async {
                    unsplashPhotoViewModel.setListOfPhotos(list: result)
                    self.updateUI(scrollToTop: true)
                }
            }
            PanelAnimationController.closePanel(panel: orderPanel, animation: true)
        }
    }
    
    @IBAction func onColorButtonClick(sender: UIButton) {
        var fetchPhotos = false
        let buttonTitle = sender.title(for: .normal)
        if buttonTitle == "Color" {
            PanelAnimationController.showPanel(panel: colorPanel)
        } else if buttonTitle == "Any color" {
            if currentColor == .any {
                toast.show(text: "It is already Any color.")
            } else {
                currentColor = .any
                fetchPhotos = true
            }
        } else if buttonTitle == "Black and white" {
            if currentColor == .blackAndWhite {
                toast.show(text: "It is already Black and white.")
            } else {
                currentColor = .blackAndWhite
                fetchPhotos = true
            }
        } else if buttonTitle == "White" {
            if currentColor == .white {
                toast.show(text: "It is already White.")
            } else {
                currentColor = .white
                fetchPhotos = true
            }
        } else if buttonTitle == "Black" {
            if currentColor == .black {
                toast.show(text: "It is already Black.")
            } else {
                currentColor = .black
                fetchPhotos = true
            }
        } else if buttonTitle == "Yellow" {
            if currentColor == .yellow {
                toast.show(text: "It is already Yellow.")
            } else {
                currentColor = .yellow
                fetchPhotos = true
            }
        } else if buttonTitle == "Orange" {
            if currentColor == .orange {
                toast.show(text: "It is already Orange.")
            } else {
                currentColor = .orange
                fetchPhotos = true
            }
        } else if buttonTitle == "Red" {
            if currentColor == .red {
                toast.show(text: "It is already Red.")
            } else {
                currentColor = .red
                fetchPhotos = true
            }
        } else if buttonTitle == "Purple" {
            if currentColor == .purple {
                toast.show(text: "It is already Purple.")
            } else {
                currentColor = .purple
                fetchPhotos = true
            }
        } else if buttonTitle == "Magenta" {
            if currentColor == .magenta {
                toast.show(text: "It is already Magenta.")
            } else {
                currentColor = .magenta
                fetchPhotos = true
            }
        } else if buttonTitle == "Green" {
            if currentColor == .green {
                toast.show(text: "It is already Green.")
            } else {
                currentColor = .green
                fetchPhotos = true
            }
        } else if buttonTitle == "Teal" {
            if currentColor == .teal {
                toast.show(text: "It is already Teal.")
            } else {
                currentColor = .teal
                fetchPhotos = true
            }
        } else if buttonTitle == "Blue" {
            if currentColor == .blue {
                toast.show(text: "It is already Blue.")
            } else {
                currentColor = .blue
                fetchPhotos = true
            }
        }
        if fetchPhotos {
            currentColorButton.setTitleColor(UIColor.lightGray, for: .normal)
            sender.setTitleColor(UIColor.black, for: .normal)
            currentColorButton = sender
            
            currentPage = 1
            indicatorView.startAnimating()
            noMoreImages = false
            unsplashPhotoViewModel.fetchUnsplashSearchPhotos(query: searchedWord, page: String(currentPage), perPage: .maximum, orderBy: currentOrderBy, color: currentColor, orientation: .portrait)  { [self] (result) -> () in
                DispatchQueue.main.async {
                    unsplashPhotoViewModel.setListOfPhotos(list: result)
                    self.updateUI(scrollToTop: true)
                }
            }
            PanelAnimationController.closePanel(panel: colorPanel, animation: true)
        }
    }
    
    @IBAction func onClosePanelButtonClick(sender: UIButton) {
        if !orderPanel.isHidden {
            PanelAnimationController.closePanel(panel: orderPanel, animation: true)
        } else if !colorPanel.isHidden {
            PanelAnimationController.closePanel(panel: colorPanel, animation: true)
        } else {
            PanelAnimationController.closePanel(panel: imageInfoPanel, animation: true)
        }
    }
    
}
