import UIKit

//MARK: - Переделать экран под скролл, добавить блюр

class FilmDescriptionController: UIViewController {
    let network = NetworkService()
    var needToGetData: Bool = true
    var loader: UIView? = nil
    var navbarTitle = ""
    var navbarIsHiden = true
    
    var film: Docs? {
        didSet{
            setViewElem()
        }
    }
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var backItemNavBar: UIBarButtonItem!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var genreLabel1: PaddingLabel!
    @IBOutlet weak var genreLabel2: PaddingLabel!
    @IBOutlet weak var genreLabel3: PaddingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        loader = Loader().getLoader(x: 0, y: 95, width: self.view.bounds.width, height: self.view.bounds.height - 95)
        view.addSubview(loader!)
        
        if needToGetData{
            network.getRandomFilm { data in
                self.film = data
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.title = navbarTitle
        backItemNavBar.isHidden = navbarIsHiden
    }
    
    //MARK: - Добавить кнопку для получения нового фильма
    @IBAction func backBarItem(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Добавить анимацию для закрытия лоадера
    func setViewElem(){
        DispatchQueue.main.async { [self] in
            self.view.addSubview(getLabel(x: 20, y: 130, width: 100, height: 60, text: "IMDb " + (film?.rating?.imdb!.description ?? "0.0"), isBold: true))
            self.view.addSubview(getLabel(x: 130, y: 130, width: 100, height: 60, text: convertMTH(min: film?.movieLength ?? 0), isBold: false))
            titleLabel.text = film?.name!
            configurationImageView()
            configurationDisplayingGenres()
            configurationDescription()
            loader?.removeFromSuperview()
        }
    }
    
    private func configurationDisplayingGenres(){
        if film?.genres.count == 3{
            genreLabelConfiguration(label: genreLabel1, text: (film?.genres[0]!.name!)!)
            genreLabelConfiguration(label: genreLabel2, text: (film?.genres[1]!.name!)!)
            genreLabelConfiguration(label: genreLabel3, text: (film?.genres[2]!.name!)!)
        }else if film?.genres.count == 2{
            genreLabelConfiguration(label: genreLabel1, text: (film?.genres[0]!.name!)!)
            genreLabelConfiguration(label: genreLabel2, text: (film?.genres[1]!.name!)!)
            genreLabel3.isHidden = true
        } else if film?.genres.count == 1 {
            genreLabelConfiguration(label: genreLabel1, text: (film?.genres[0]!.name!)!)
            genreLabel2.isHidden = true
            genreLabel3.isHidden = true
        } else {
            genreLabelConfiguration(label: genreLabel1, text: (film?.genres[0]!.name!)!)
            genreLabelConfiguration(label: genreLabel2, text: (film?.genres[1]!.name!)!)
            genreLabelConfiguration(label: genreLabel3, text: (film?.genres[2]!.name!)!)
        }
    }
    
    private func configurationImageView(){
        posterImageView.image = UIImage(data: (film?.poster?.posterData!)!)
        posterImageView.layer.cornerRadius = 30
        posterImageView.clipsToBounds = true
    }
    
    private func getLabel(x: Int, y: Int, width: Int, height: Int, text: String, isBold: Bool) -> UILabel{
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        
        label.text = text
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textAlignment = .center
        
        label.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        
        label.font = isBold ? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold) : UIFont.systemFont(ofSize: 14)
        
        return label
    }
    
    
    // MARK: - Переделать под большее количество жанров
    private func genreLabelConfiguration(label: UILabel , text: String){
        label.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
    }
    
    private func configurationDescription(){
        descriptionLabel.textColor = .black
        descriptionLabel.text = film?.description ?? film?.shortDescription
        descriptionLabel.numberOfLines = 7
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
    }
}


