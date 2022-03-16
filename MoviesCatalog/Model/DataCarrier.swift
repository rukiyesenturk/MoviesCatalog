//
//  DataCarrier.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import Foundation

class DataCarrier { // singleton ilkesi ile her veriye her yerden erişmek için bir veri taşıyıcı oluşturdum.
static var shared = [DataCarrier]().self
    
    let moviesNo : Int
    let original_title   : String
    let release_date : String
    let poster_path : String
    let overview : String

init(moviesNo : Int, original_title : String, release_date : String, overview : String, poster_path : String) {
    self.moviesNo = moviesNo
    self.original_title   = original_title
    self.release_date = release_date
    self.poster_path = poster_path
    self.overview = overview
}
}
