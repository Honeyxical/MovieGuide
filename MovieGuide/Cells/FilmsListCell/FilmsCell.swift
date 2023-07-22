import Kingfisher
import UIKit

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
        guard let film = film, let filmName = film.name, let shortDescription = film.shortDescription ?? film.description else { return }
        setPoster()
        titleLabel.text = filmName
        shortDescriptionLabel.text = shortDescription
    }
}

extension FilmsCell {
    private func setPoster() {
        guard let film = film, let poster = film.poster, let posterUrl = poster.previewUrl ?? poster.url else { return }

        filmImage.kf.setImage(with: URL(string: posterUrl))
    }
}
