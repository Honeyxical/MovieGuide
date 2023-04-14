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
        if image != nil {
            filmImage.image = UIImage(data: image!)
        } else{
            filmImage.image = Loader().palceholderImage()
        }
        titleLabel.text! = title
        shortDescriptionLabel.text! = shortDescription
    }
}
