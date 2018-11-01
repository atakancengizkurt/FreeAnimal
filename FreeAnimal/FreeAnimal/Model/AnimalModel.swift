//
//  AnimalModel.swift
//  FreeAnimal
//
//  Created by Glny Gl on 12.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import Foundation

struct Animal: Codable{
    var total: Int?
    var total_pages: Int?
    var results: [Results]?
}

struct Results: Codable{
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var width: Int?
    var height: Int?
    var color: String?
    var description: String?
    var urls: Urls?
    var links: ResultLinks?
    // var categories: [Any]?
    var sponsored: Bool?
    var likes: Int?
    var likedByUser: Bool?
    //  var currentUserCollections: [Any]?
    var user: User?
    var tags, photoTags: [Tag]?
}

struct Urls: Codable {
    
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
}

struct ResultLinks: Codable {
    
    var linksSelf: String?
    var html: String?
    var download: String?
    var downloadLocation: String?
}

struct User: Codable {
    
    var id: String?
    var updatedAt: Date?
    var username: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var twitterUsername: String?
    var portfolioURL: String?
    var bio: String?
    var location: String?
    var links: UserLinks?
    var profileImage: ProfileImage?
    var instagramUsername: String?
    var totalCollections: Int?
    var totalLikes: Int?
    var totalPhotos: Int?
    var acceptedTos: Bool?
    
}

struct Tag: Codable {
    
    var title: String?
}

struct UserLinks: Codable {
    
    var linksSelf: String?
    var html: String?
    var photos: String?
    var likes: String?
    var portfolio: String?
    var following: String?
    var followers: String?
    
}

struct ProfileImage: Codable {
    
    var small: String?
    var medium: String?
    var large: String?
}




