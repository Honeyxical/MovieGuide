import UIKit

class FilmsCell: UITableViewCell {
    
    var film: FilmShortInfo? {
        didSet{
            
            guard let film = film else {
                return
            }
            DispatchQueue.main.async { [self] in
                setPoster()
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
        filmImage.image = UIImage(named: "PlaceholderImage")
        filmImage.contentMode = .scaleAspectFill
    }
}

extension FilmsCell {
    private func setPoster() {
        guard let posterUrl = film?.poster?.previewUrl ?? film?.poster?.url! else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: posterUrl)!)) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async { [self] in
                filmImage.image = UIImage(data: data)
            }
        }.resume()
    }
}
