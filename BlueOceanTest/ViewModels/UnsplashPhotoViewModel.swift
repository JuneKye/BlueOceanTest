//
//  UnsplashPhotoViewModel.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/07.
//

import UIKit

class UnsplashPhotoViewModel: NSObject {
    var listOfUnsplashPhotoModels = NSMutableArray.init()
    
    private let NO_IMAGE_DESCRIPTION = "NO TITLE"
    private let NO_IMAGE_ALT_DESCRIPTION = "There is no description for this image."
    
    override init() {
        // do nothing
    }
    
    init(list: NSMutableArray) {
        listOfUnsplashPhotoModels = list
    }
    
    func setListOfPhotos(list: NSMutableArray) {
        listOfUnsplashPhotoModels = list
    }
    
    func appendListOfPhotos(list: NSMutableArray) {
        listOfUnsplashPhotoModels.addObjects(from: list as! [Any])
    }
    
    func getNumOfPhotoModels() -> Int {
        return listOfUnsplashPhotoModels.count
    }
    
    func getUserID(index: Int) -> String? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).userID
    }
    
    func getImageDescription(index: Int) -> String {
        let imageDescription = (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).imageDescription
        if imageDescription == nil {
            return NO_IMAGE_DESCRIPTION
        } else {
            return imageDescription!
        }
    }
    
    func getCategories(index: Int) -> NSArray? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).categories
    }
    
    func getSponsorship(index: Int) -> NSDictionary? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).sponsorship
    }
    
    func getCreatedTime(index: Int) -> String? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).createdAt
    }
    
    func getWidth(index: Int) -> Int64? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).width
    }
    
    func getNumOfLikes(index: Int) -> Int64? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).likes
    }
    
    func getBlurHash(index: Int) -> String? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).blurHash
    }
    
    func getImageAltDescription(index: Int) -> String {
        let imageAltDescription = (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).imageAltDescription
        if imageAltDescription == nil {
            return NO_IMAGE_ALT_DESCRIPTION
        } else {
            return imageAltDescription!
        }
    }
    
    func getColor(index: Int) -> String? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).color
    }
    
    func getImageURLs(index: Int) -> NSDictionary? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).imageURLs
    }
    
    func getImageURL(index: Int, urlBasedOnSize: UnsplashPhotoModel.Size) -> String? {
        if (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).imageURLs == nil {
            return nil
        } else {
            return ((listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).imageURLs!.object(forKey: urlBasedOnSize.rawValue) as? String)
        }
    }
    
    func getCurrentUserCollections(index: Int) -> NSArray? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).currentUserCollections
    }
    
    func getTags(index: Int) -> NSArray? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).tags
    }
    
    func getUpdatedTime(index: Int) -> String? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).updatedAt
    }
    
    func getHeight(index: Int) -> Int64? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).height
    }
    
    func getLinks(index: Int) -> NSDictionary? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).links
    }
    
    func getLikedByUser(index: Int) -> Bool? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).likedByUser
    }
    
    func getPromotedTime(index: Int) -> String? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).promotedAt
    }
    
    func getUserInfo(index: Int) -> NSDictionary? {
        return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).userInfo
    }
    
    func getUserName(index: Int) -> String? {
        if (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).userInfo == nil {
            return nil
        } else {
            return (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).userInfo!.object(forKey: "name") as? String
        }
    }
    
    func getUserProfileImageURL(index: Int) -> String? {
        if (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).userInfo == nil {
            return ""
        } else {
            let profileImageDict = (listOfUnsplashPhotoModels[index] as! UnsplashPhotoModel).userInfo!.object(forKey: "profile_image") as? NSDictionary
            if profileImageDict == nil {
                return ""
            } else {
                return profileImageDict?.object(forKey: "large") as? String
            }
        }
    }
    
    func fetchUnsplashPhotos(page: String, perPage: UnsplashAPI.PerPage, order: UnsplashAPI.OrderByForPhotos, completion: @escaping (NSMutableArray)->()) {
        UnsplashAPI.sharedInstance.fetchUnsplashPhotos(page: page, perPage: perPage, orderByForPhotos: order) { (result) -> () in
            completion(result)
        }
    }
    
    func fetchUnsplashSearchPhotos(query: String, page: String, perPage: UnsplashAPI.PerPage, orderBy: UnsplashAPI.OrderByForSearchPhotos, color: UnsplashAPI.Color, orientation: UnsplashAPI.Orientation, completion: @escaping (NSMutableArray)->()) {
        UnsplashAPI.sharedInstance.fetchUnsplashSearchPhotos(query: query, page: page, perPage: perPage, orderByForSearchPhotos: orderBy, color: color, orientation: orientation) { (result) -> () in
            completion(result)
        }
    }
    
}
