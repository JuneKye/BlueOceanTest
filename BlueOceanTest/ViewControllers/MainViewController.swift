//
//  MainViewController.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/07.
//

import Alamofire
import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var imageInfoPanel: UIView!
    @IBOutlet weak var searchPanel: UIView!
    @IBOutlet weak var orderPanel: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var latestOrderButton: UIButton!
    @IBOutlet weak var searchWord: UITextField!
    @IBOutlet weak var imageInfo: UILabel!
    @IBOutlet weak var toast: Toast!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var currentPage = 1
    private var currentOrderBy = UnsplashAPI.OrderByForPhotos.latest
    private var currentOrderButton: UIButton!
    private var noMoreImages = false
    
    private let unsplashPhotoViewModel = UnsplashPhotoViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "TableViewCellForUnsplashImage", bundle: nil), forCellReuseIdentifier: "TableViewCellForUnsplashImage")
        
        indicatorView.startAnimating()
        unsplashPhotoViewModel.fetchUnsplashPhotos(page: String(currentPage), perPage: .defaultForPhotos, order: currentOrderBy) { [self] (result) -> () in
            DispatchQueue.main.async {
                unsplashPhotoViewModel.setListOfPhotos(list: result)
                self.updateUI(scrollToTop: true)
            }
        }
        
        searchWord.delegate = self
        
        currentOrderButton = latestOrderButton
    }
    
    private func updateUI(scrollToTop: Bool) {
        tableView.reloadData()
        if scrollToTop {
            if unsplashPhotoViewModel.getNumOfPhotoModels() >= 1 {
                tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: false)
            } else {
                toast.show(text: "No images are available this time.")
            }
        }
        indicatorView.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unsplashPhotoViewModel.getNumOfPhotoModels()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellForUnsplashImage", for: indexPath) as! TableViewCellForUnsplashImage
        unsplashPhotoViewModel.configureForPhotos(tableViewCell: cell, index: indexPath.row)
        
        if !noMoreImages && indexPath.row == unsplashPhotoViewModel.getNumOfPhotoModels() - 1 {
            currentPage += 1
            indicatorView.startAnimating()
            unsplashPhotoViewModel.fetchUnsplashPhotos(page: String(currentPage), perPage: .defaultForPhotos, order: currentOrderBy) { [self] (result) -> () in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PanelAnimationController.showPanel(panel: imageInfoPanel)
        
        unsplashPhotoViewModel.configureForImageInfo(label: imageInfo, index: indexPath.row)
    }
    
    @IBAction func onOrderByButtonClick(sender: UIButton) {
        var fetchPhotos = false
        let buttonTitle = sender.title(for: .normal)
        if buttonTitle == "Sort" {
            PanelAnimationController.showPanel(panel: orderPanel)
        } else if buttonTitle == "Latest" {
            if currentOrderBy == .latest {
                toast.show(text: "It is already sorted by Latest.")
            } else {
                currentOrderBy = .latest
                fetchPhotos = true
            }
        } else if buttonTitle == "Oldest" {
            if currentOrderBy == .oldest {
                toast.show(text: "It is already sorted by Oldest.")
            } else {
                currentOrderBy = .oldest
                fetchPhotos = true
            }
        } else {
            if currentOrderBy == .popular {
                toast.show(text: "It is already sorted by Popular.")
            } else {
                currentOrderBy = .popular
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
            unsplashPhotoViewModel.fetchUnsplashPhotos(page: String(currentPage), perPage: .defaultForPhotos, order: currentOrderBy) { [self] (result) -> () in
                DispatchQueue.main.async {
                    unsplashPhotoViewModel.setListOfPhotos(list: result)
                    self.updateUI(scrollToTop: true)
                }
            }
            PanelAnimationController.closePanel(panel: orderPanel, animation: true)
        }
    }
    
    @IBAction func onShowSearchPanelClick(sender: UIButton) {
        PanelAnimationController.showPanel(panel: searchPanel)
        searchWord.text = ""
    }
    
    @IBAction func onCancelClick(sender: UIButton) {
        PanelAnimationController.closePanel(panel: searchPanel, animation: true)
    }
    
    @IBAction func onSearchClick(sender: UIButton) {
        let word = searchWord.text?.trimmingCharacters(in: .whitespacesAndNewlines).capitalizingFirstLetter()
        if word!.count == 0 {
            toast.show()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
                PanelAnimationController.closePanel(panel: searchPanel, animation: false)
            })
            self.performSegue(withIdentifier: "SearchViewController", sender: word)
        }
    }
    
    @IBAction func onClosePanelButtonClick(sender: UIButton) {
        if !orderPanel.isHidden {
            PanelAnimationController.closePanel(panel: orderPanel, animation: true)
        } else if !searchPanel.isHidden {
            PanelAnimationController.closePanel(panel: searchPanel, animation: true)
        } else {
            PanelAnimationController.closePanel(panel: imageInfoPanel, animation: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SearchViewController
        vc.searchedWord = sender as? String
    }

}
