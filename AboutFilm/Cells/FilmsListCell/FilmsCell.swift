//
//  FilmsCell.swift
//  AboutFilm
//
//  Created by илья on 05.04.23.
//

import UIKit

class FilmsCell: UITableViewCell {

    @IBOutlet weak private var filmImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var shortDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: UIImage, title: String, shrotDescription: String){
        
        
    }
}
