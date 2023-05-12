import UIKit

class ProfileController: UIViewController {
    
    
    private let porfileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Ghost"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let nameAndEmailTextView: UITextView = {
        let text = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "")
        
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
