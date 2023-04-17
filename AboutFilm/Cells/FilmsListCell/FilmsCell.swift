import UIKit

class FilmsCell: UITableViewCell {
    
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filmImage.image = Loader().palceholderImage()
        filmImage.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: Data, title: String, shortDescription: String){
        filmImage.image = UIImage(data: image)
        titleLabel.text! = title
        shortDescriptionLabel.text! = shortDescription
    }
    
}
