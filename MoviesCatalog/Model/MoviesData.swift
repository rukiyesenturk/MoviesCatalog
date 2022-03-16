//
//  MoviesData.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import Foundation
import UIKit

struct MoviesData : Codable{
    let results : [result]
    struct result : Codable {
        let original_title : String
        let  release_date : String
        let poster_path : String
        let overview : String
    
    }
}
