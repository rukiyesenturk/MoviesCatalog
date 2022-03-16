//
//  MovieImageData.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import Foundation
struct MovieImageData : Codable{
    let data : DatasImage
}

struct DatasImage : Codable{
    let id : String
    let poster_path : String
    let overview : String
}
