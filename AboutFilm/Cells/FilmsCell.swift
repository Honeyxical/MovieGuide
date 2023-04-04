//
//  FilmsCell.swift
//  AboutFilm
//
//  Created by илья on 04.04.23.
//

import UIKit

class FilmsCell: UITableViewCell {
    static let id = "FilmsCell"
    
    @IBOutlet weak var filmsCell: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
