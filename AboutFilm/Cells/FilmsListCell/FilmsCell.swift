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
    
    func configure(image: Data?, title: String, shortDescription: String){
        guard let image = image else {
            titleLabel.text! = title
            shortDescriptionLabel.text! = shortDescription
            return
        }
        filmImage.image = UIImage(data: image)
        titleLabel.text! = title
        shortDescriptionLabel.text! = shortDescription
    }
}
