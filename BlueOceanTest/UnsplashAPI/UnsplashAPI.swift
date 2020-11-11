//
//  UnsplashAPI.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/10.
//

import Alamofire

class UnsplashAPI: NSObject {
    private var unsplashAccessKey = "P6m6UNGLMyjdXs8539Ri9gsL6Jq-kK92RwXN7gT_u10"
    
    private let UNSPLASH_URL_PHOTOS = "https://api.unsplash.com/photos"
    private let UNSPLASH_URL_SEARCH_PHOTOS = "https://api.unsplash.com/search/photos"
    
    enum PerPage: String {
        case defaultForPhotos = "20"
        case defaultForSearch = "10"
        case maximum = "30"
    }
    
    enum OrderByForPhotos: String {
        case latest = "latest"
        case oldest = "oldest"
        case popular = "popular"
    }
    
    enum OrderByForSearchPhotos: String {
        case relevant = "relevant"
        case latest = "latest"
    }
    
    enum Color: String {
        case any = ""
        case blackAndWhite = "black_and_white"
        case black = "black"
        case white = "white"
        case yellow = "yellow"
        case orange = "orange"
        case red = "red"
        case purple = "purple"
        case magenta = "magenta"
        case green = "green"
        case teal = "teal"
        case blue = "blue"
    }
    
    enum Orientation: String {
        case landscape = "landscape"
        case portrait = "portrait"
        case squarish = "squarish"
    }
    
    private override init() {}
    
    static let sharedInstance: UnsplashAPI = UnsplashAPI()
    
    func setAccessKey(accessKey: String) {
        unsplashAccessKey = accessKey
    }
    
    func fetchUnsplashPhotos(page: String, perPage: PerPage, orderByForPhotos: OrderByForPhotos, completion: @escaping (NSMutableArray)->()) {
        let headers: HTTPHeaders = [.authorization("Client-ID " + unsplashAccessKey),
                                    .accept("application/json")]
        let parameters = ["page" : page,
                          "per_page" : perPage.rawValue,
                          "order_by" : orderByForPhotos.rawValue]
        AF.request(UNSPLASH_URL_PHOTOS, parameters: parameters, headers: headers).responseJSON { response in
            let listOfUnsplashPhotoModels = NSMutableArray.init()
            if let list = response.value as? [NSDictionary] {
                for dictionary in list {
                    let unsplashPhotoModel = UnsplashPhotoModel.init(userID: dictionary.object(forKey: "id") as? String,
                                                                     imageDescription: dictionary.object(forKey: "description") as? String,
                                                                     categories: dictionary.object(forKey: "categories") as? NSArray,
                                                                     sponsorship: dictionary.object(forKey: "sponsorship") as? NSDictionary,
                                                                     createdAt: dictionary.object(forKey: "created_at") as? String,
                                                                     width: dictionary.object(forKey: "width") as? Int64,
                                                                     likes: dictionary.object(forKey: "likes") as? Int64,
                                                                     blurHash: dictionary.object(forKey: "blur_hash") as? String,
                                                                     imageAltDescription: dictionary.object(forKey: "alt_description") as? String,
                                                                     color: dictionary.object(forKey: "color") as? String,
                                                                     imageURLs: dictionary.object(forKey: "urls") as? NSDictionary,
                                                                     currentUserCollections: dictionary.object(forKey: "current_user_collections") as? NSArray,
                                                                     updatedAt: dictionary.object(forKey: "updated_at") as? String,
                                                                     height: dictionary.object(forKey: "height") as? Int64,
                                                                     links: dictionary.object(forKey: "links") as? NSDictionary,
                                                                     likedByUser: dictionary.object(forKey: "liked_by_user") as? Bool,
                                                                     promotedAt: dictionary.object(forKey: "promoted_at") as? String,
                                                                     userInfo: dictionary.object(forKey: "user") as? NSDictionary)
                    listOfUnsplashPhotoModels.add(unsplashPhotoModel)
                }
            }
            completion(listOfUnsplashPhotoModels)
        }
    }
    
    func fetchUnsplashSearchPhotos(query: String, page: String, perPage: PerPage, orderByForSearchPhotos: OrderByForSearchPhotos, color: Color, orientation: Orientation, completion: @escaping (NSMutableArray)->()) {
        let headers: HTTPHeaders = [.authorization("Client-ID " + unsplashAccessKey),
                                    .accept("application/json")]
        var parameters = ["query" : query]
        parameters["page"] = page
        parameters["per_page"] = perPage.rawValue
        parameters["order_by"] = orderByForSearchPhotos.rawValue
        if color != .any {
            parameters["color"] = color.rawValue
        }
        parameters["orientation"] = orientation.rawValue
        AF.request(UNSPLASH_URL_SEARCH_PHOTOS, parameters: parameters, headers: headers).responseJSON { response in
            let listOfUnsplashPhotoModels = NSMutableArray.init()
            if let resultDictionary = response.value as? NSDictionary {
                let list = resultDictionary.object(forKey: "results") as! [NSDictionary]
                for dictionary in list {
                    let unsplashPhotoModel = UnsplashPhotoModel.init(userID: dictionary.object(forKey: "id") as? String,
                                                                     imageDescription: dictionary.object(forKey: "description") as? String,
                                                                     categories: dictionary.object(forKey: "categories") as? NSArray,
                                                                     sponsorship: dictionary.object(forKey: "sponsorship") as? NSDictionary,
                                                                     createdAt: dictionary.object(forKey: "created_at") as? String,
                                                                     width: dictionary.object(forKey: "width") as? Int64,
                                                                     likes: dictionary.object(forKey: "likes") as? Int64,
                                                                     blurHash: dictionary.object(forKey: "blur_hash") as? String,
                                                                     imageAltDescription: dictionary.object(forKey: "alt_description") as? String,
                                                                     color: dictionary.object(forKey: "color") as? String,
                                                                     imageURLs: dictionary.object(forKey: "urls") as? NSDictionary,
                                                                     currentUserCollections: dictionary.object(forKey: "current_user_collections") as? NSArray,
                                                                     tags: dictionary.object(forKey: "tags") as? NSArray,
                                                                     updatedAt: dictionary.object(forKey: "updated_at") as? String,
                                                                     height: dictionary.object(forKey: "height") as? Int64,
                                                                     links: dictionary.object(forKey: "links") as? NSDictionary,
                                                                     likedByUser: dictionary.object(forKey: "liked_by_user") as? Bool,
                                                                     promotedAt: dictionary.object(forKey: "promoted_at") as? String,
                                                                     userInfo: dictionary.object(forKey: "user") as? NSDictionary)
                    listOfUnsplashPhotoModels.add(unsplashPhotoModel)
                }
            }
            completion(listOfUnsplashPhotoModels)
        }
    }

}
