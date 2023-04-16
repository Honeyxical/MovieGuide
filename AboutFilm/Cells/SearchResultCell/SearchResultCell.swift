import UIKit

class SearchResultCell: UITableViewCell {
    
    var film: SearchFilmInfo? = nil

    @IBOutlet weak private var posterImageView: UIImageView!
    
    @IBOutlet weak private var filmNameLabel: UILabel!
    
    @IBOutlet weak private var secondNameYearLabel: UILabel!
    
    @IBOutlet weak private var countryGenresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFilmNameLabel()
        configureSecondNameYearLabel()
        configureCountryGenresLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(){
        guard let film = film else {
            return
        }
        
        if film.posterData != nil{
            posterImageView.image = UIImage(data: film.posterData!)
        } else {
            posterImageView.contentMode = .scaleAspectFill
            posterImageView.image = Loader().palceholderImage()
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
}
