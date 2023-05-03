import UIKit

class FilmsCell: UITableViewCell {
    
    var film: FilmShortInfo? {
        didSet{
            
            guard let film = film else {
                return
            }
            
            DispatchQueue.main.async { [self] in
                if film.poster?.posterData != nil {
                    filmImage.image = UIImage(data: film.poster!.posterData!)
                }
                titleLabel.text! = film.name!
                shortDescriptionLabel.text! = film.shortDescription ?? film.description!
            }
        }
    }
    
    @IBOutlet weak private var filmImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var shortDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filmImage.image = Loader().palceholderImage()
        filmImage.contentMode = .scaleAspectFill
    }
}
