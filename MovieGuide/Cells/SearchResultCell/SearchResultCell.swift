import UIKit
import Kingfisher

class SearchResultCell: UITableViewCell {
    
    var film: SearchFilmInfo? {
        didSet {
            setPoster()
            
        }
    }

    @IBOutlet weak private var posterImageView: UIImageView!
    
    @IBOutlet weak private var filmNameLabel: UILabel!
    
    @IBOutlet weak private var secondNameYearLabel: UILabel!
    
    @IBOutlet weak private var countryGenresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureImageView()
        configureFilmNameLabel()
        configureSecondNameYearLabel()
        configureCountryGenresLabel()
        
        URLCache.shared = URLCache(memoryCapacity: 500 * 1024 * 1024, diskCapacity: 500 * 1024 * 1024)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(){
        guard let film = film else {
            return
        }
        filmNameLabel.text = film.name!
        secondNameYearLabel.text = film.alternativeName! == "" ? String(film.year!) : "\(film.alternativeName!), \(String(film.year!))"
        countryGenresLabel.text = arrayToString(array: film.countries!) + " • " + arrayToString(array: film.genres!)
    }
    
    private func configureFilmNameLabel(){
        filmNameLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        filmNameLabel.numberOfLines = 1
    }
    
    private func configureSecondNameYearLabel(){
        secondNameYearLabel.numberOfLines = 1
        secondNameYearLabel.font = UIFont.systemFont(ofSize: 14)
        secondNameYearLabel.textColor = .lightGray
    }
    
    private func configureCountryGenresLabel(){
        countryGenresLabel.textColor = UIColor.gray
        countryGenresLabel.numberOfLines = 2
        countryGenresLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func configureImageView(){
        posterImageView.image = UIImage(named: "PlaceholderImage")
        posterImageView.contentMode = .scaleAspectFill
    }
}

extension SearchResultCell {
    private func setPoster() {
        guard let posterUrl = film?.poster else { return }
        
        posterImageView.kf.setImage(with: URL(string: posterUrl))
    }
}
