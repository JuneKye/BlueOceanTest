//
//  UnsplashPhotoModel.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/07.
//

import UIKit

class UnsplashPhotoModel: NSObject {
    var userID: String?
    var imageDescription: String?
    var categories: NSArray?
    var sponsorship: NSDictionary?
    var createdAt: String?
    var width: Int64?
    var likes: Int64?
    var blurHash: String?
    var imageAltDescription: String?
    var color: String?
    var imageURLs: NSDictionary?
    var currentUserCollections: NSArray?
    var tags: NSArray?
    var updatedAt: String?
    var height: Int64?
    var links: NSDictionary?
    var likedByUser: Bool?
    var promotedAt: String?
    var userInfo: NSDictionary?
    
    enum Size: String {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
    
    init(userID: String?, imageDescription: String?, categories: NSArray?, sponsorship: NSDictionary?, createdAt: String?, width: Int64?, likes: Int64?, blurHash: String?, imageAltDescription: String?, color: String?, imageURLs: NSDictionary?, currentUserCollections: NSArray?, tags: NSArray?, updatedAt: String?, height: Int64?, links: NSDictionary?, likedByUser: Bool?, promotedAt: String?, userInfo: NSDictionary?) {
        self.userID = userID
        self.imageDescription = imageDescription
        self.categories = categories
        self.sponsorship = sponsorship
        self.createdAt = createdAt
        self.width = width
        self.likes = likes
        self.blurHash = blurHash
        self.imageAltDescription = imageAltDescription
        self.color = color
        self.imageURLs = imageURLs
        self.currentUserCollections = currentUserCollections
        self.tags = tags
        self.updatedAt = updatedAt
        self.height = height
        self.links = links
        self.likedByUser = likedByUser
        self.promotedAt = promotedAt
        self.userInfo = userInfo
    }
    
    convenience init(userID: String?, imageDescription: String?, categories: NSArray?, sponsorship: NSDictionary?, createdAt: String?, width: Int64?, likes: Int64?, blurHash: String?, imageAltDescription: String?, color: String?, imageURLs: NSDictionary?, currentUserCollections: NSArray?, updatedAt: String?, height: Int64?, links: NSDictionary?, likedByUser: Bool?, promotedAt: String?, userInfo: NSDictionary?) {
        self.init(userID: userID, imageDescription: imageDescription, categories: categories, sponsorship: sponsorship, createdAt: createdAt, width: width, likes: likes, blurHash: blurHash, imageAltDescription: imageAltDescription, color: color, imageURLs: imageURLs, currentUserCollections: currentUserCollections, tags: nil, updatedAt: updatedAt, height: height, links: links, likedByUser: likedByUser, promotedAt: promotedAt, userInfo: userInfo)
    }

}
