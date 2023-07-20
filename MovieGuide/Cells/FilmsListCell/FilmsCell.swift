import UIKit
import Kingfisher

class FilmsCell: UITableViewCell {

    var film: FilmShortInfo?
    
    @IBOutlet weak private var filmImage: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var shortDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filmImage.image = UIImage(named: "PlaceholderImage")
        filmImage.contentMode = .scaleAspectFill
    }

    func setData() {
        guard let film = film else {
            return
        }
        setPoster()
        titleLabel.text! = film.name!
        shortDescriptionLabel.text! = film.shortDescription ?? film.description ?? "Description is missing"
    }
}

extension FilmsCell {
    private func setPoster() {
        guard let posterUrl = film?.poster?.previewUrl ?? film?.poster?.url! else { return }

        filmImage.kf.setImage(with: URL(string: posterUrl))
    }
}
