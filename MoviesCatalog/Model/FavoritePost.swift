//
//  FavoritePost.swift
//  MoviesCatalog
//
//  Created by Macbook on 14.03.2022.
//

import Foundation
class FavoritePost {
    var moviesName : String
    var imageUrl :String
    
    init(moviesName : String, imageUrl : String){
        self.moviesName = moviesName
        self.imageUrl = imageUrl
    }
}
