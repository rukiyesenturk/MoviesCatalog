//
//  NewsCell.swift
//  MoviesCatalog
//
//  Created by Macbook on 13.03.2022.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var moviesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
