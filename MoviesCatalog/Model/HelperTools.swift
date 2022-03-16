//
//  HelperTools.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import Foundation
import UIKit

class HelperTools{
    func addToDataCarrier (moviesModel: [MoviesModel]){ // to fill  all information inside to singleton prenciple. i am accessing everywhere all information with this way.
        
        DataCarrier.shared.removeAll()
        for (i,item) in moviesModel.enumerated() {
            let values = DataCarrier(moviesNo: i, original_title: item.original_title, release_date: item.release_date, overview: item.overview, poster_path: item.poster_path)
            DataCarrier.shared.append(values)
            
        }
    }
    func tableViewSeparator(tableView : UITableView){
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
}
