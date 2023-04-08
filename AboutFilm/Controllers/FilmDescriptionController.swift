import UIKit

class FilmDescriptionController: UIViewController {
    
    var filmTitle = ""
    var filmDescription = ""
    var poster: Data? = nil
    var filmDuration = ""
    var imbd: String = "IMDb "
    var genres: [String] = []
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var backItemNavBar: UIBarButtonItem!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var genreLabel1: PaddingLabel!
    @IBOutlet weak var genreLabel2: PaddingLabel!
    @IBOutlet weak var genreLabel3: PaddingLabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(getLabel(x: 20, y: 130, width: 100, height: 60, text: imbd , isBold: true))
        self.view.addSubview(getLabel(x: 130, y: 130, width: 100, height: 60, text: filmDuration, isBold: false))
        
        titleLabel.text = filmTitle
        
        genreLabelConfiguration(label: genreLabel1, text: genres[0])
        genreLabelConfiguration(label: genreLabel2, text: genres[1])
        genreLabelConfiguration(label: genreLabel3, text: genres[2])
        
        configurationDescription(label: descriptionLabel)
    }
    
    @IBAction func backBarItem(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configurationImageView(){
        titleLabel.text = filmTitle
        posterImageView.layer.cornerRadius = 30
        posterImageView.clipsToBounds = true
    }
    
    private func getLabel(x: Int, y: Int, width: Int, height: Int, text: String, isBold: Bool) -> UILabel{
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        
        label.text = text
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.textAlignment = .center
        
        label.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        
        label.font = isBold ? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold) : UIFont.systemFont(ofSize: 14)
        
        return label
    }
    
    private func genreLabelConfiguration(label: UILabel , text: String){
        label.backgroundColor = UIColor(red: 29, green: 29, blue: 29, alpha: 0.1)
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
    }
    
    private func configurationDescription(label: UILabel){
        label.textColor = .lightGray
        label.text = filmDescription
        label.numberOfLines = 7
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.thin)
    }
}

