//
//  UnsplashPhotoViewModel+configure.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import Nuke
import UIKit

extension UnsplashPhotoViewModel {
    
    func configureForPhotos(tableViewCell: TableViewCellForUnsplashImage, index: Int) {
        Nuke.loadImage(with: URL.init(string: getImageURL(index: index, urlBasedOnSize: .small)!)!, into: tableViewCell.unsplashImage)
        Nuke.loadImage(with: URL.init(string: getUserProfileImageURL(index: index)!)!, into: tableViewCell.profileImage)
        
        let entireDescription = NSMutableAttributedString.init()
        let description = getImageDescription(index: index).trimmingCharacters(in: .whitespacesAndNewlines)
        let attriString1 = NSAttributedString.init(string: description + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        entireDescription.append(attriString1)
        let altDescription = getImageAltDescription(index: index).trimmingCharacters(in: .whitespacesAndNewlines)
        let attriString2 = NSAttributedString.init(string: altDescription, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
            entireDescription.append(attriString2)
        tableViewCell.entireDescription.attributedText = entireDescription
    }
    
    func configureForImageInfo(label: UILabel, index: Int) {
        let result = NSMutableAttributedString.init()
        
        var userName = self.getUserName(index: index)
        if userName == nil {
            userName = "(null)"
        }
        let attriStringForUserName1 = NSAttributedString.init(string: "Name : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForUserName2 = NSAttributedString.init(string: userName! + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForUserName1)
        result.append(attriStringForUserName2)
        
        var userID = self.getUserID(index: index)
        if userID == nil {
            userID = "(null)"
        }
        let attriStringForUserID1 = NSAttributedString.init(string: "User ID : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForUserID2 = NSAttributedString.init(string: userID! + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForUserID1)
        result.append(attriStringForUserID2)
        
        var createdTime = self.getCreatedTime(index: index)
        if createdTime == nil {
            createdTime = "(null)"
        }
        let attriStringForCreatedTime1 = NSAttributedString.init(string: "Created Time : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForCreatedTime2 = NSAttributedString.init(string: createdTime! + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForCreatedTime1)
        result.append(attriStringForCreatedTime2)
        
        var updatedTime = self.getUpdatedTime(index: index)
        if updatedTime == nil {
            updatedTime = "(null)"
        }
        let attriStringForUpdatedTime1 = NSAttributedString.init(string: "Updated Time : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForUpdatedTime2 = NSAttributedString.init(string: updatedTime! + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForUpdatedTime1)
        result.append(attriStringForUpdatedTime2)
        
        var promotedTime = self.getPromotedTime(index: index)
        if promotedTime == nil {
            promotedTime = "(null)"
        }
        let attriStringForPromotedTime1 = NSAttributedString.init(string: "Promoted Time : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForPromotedTime2 = NSAttributedString.init(string: promotedTime! + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForPromotedTime1)
        result.append(attriStringForPromotedTime2)
        
        let widthString: String
        let width = self.getWidth(index: index)
        if width == nil {
            widthString = "(null)"
        } else {
            widthString = String(width!)
        }
        let attriStringForWidth1 = NSAttributedString.init(string: "Width : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForWidth2 = NSAttributedString.init(string: widthString + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForWidth1)
        result.append(attriStringForWidth2)
        
        let heightString: String
        let height = self.getHeight(index: index)
        if height == nil {
            heightString = "(null)"
        } else {
            heightString = String(height!)
        }
        let attriStringForHeight1 = NSAttributedString.init(string: "Height : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForHeight2 = NSAttributedString.init(string: heightString + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForHeight1)
        result.append(attriStringForHeight2)
        
        var color = self.getColor(index: index)
        if color == nil {
            color = "(null)"
        }
        let attriStringForColor1 = NSAttributedString.init(string: "Color : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForColor2 = NSAttributedString.init(string: String(color!) + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForColor1)
        result.append(attriStringForColor2)
        
        var blurHash = self.getBlurHash(index: index)
        if blurHash == nil {
            blurHash = "(null)"
        }
        let attriStringForBlurHash1 = NSAttributedString.init(string: "Blur Hash : ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        let attriStringForBlurHash2 = NSAttributedString.init(string: String(blurHash!) + "\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
        result.append(attriStringForBlurHash1)
        result.append(attriStringForBlurHash2)
        
        label.attributedText = result
    }
    
    func configureForSearchPhotos(collectionViewCell: CollectionViewCellForUnsplashImage, index: Int) {
        Nuke.loadImage(with: URL.init(string: getImageURL(index: index, urlBasedOnSize: .thumb)!)!, into: collectionViewCell.unsplashImage)
    }
    
}
