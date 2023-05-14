import UIKit

class ProfileController: UIViewController {
//    let user = Auth.auth.getCurrentUser()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .mainGray
        return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Ghost"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var nameAndEmailTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.minimumLineHeight = 30
        
        let attributedText = NSMutableAttributedString(string: "Ilya Benikov", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        attributedText.append(NSAttributedString(string: "\nvatnaya1997@gmail.com", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .thin), NSAttributedString.Key.paragraphStyle: titleParagraphStyle]))
        
        text.attributedText = attributedText
        text.textAlignment = .center
        text.textContainer.maximumNumberOfLines = 2
        return text
    }()
    
    private let separator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.borderColor = UIColor.mainGray.cgColor
        line.layer.borderWidth = 1
        return line
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .custom)
        let pencil = UIImageView(image: UIImage(systemName: "pencil"))
        let label = UILabel()
        let icon = UIImageView(image: UIImage(systemName: "chevron.forward"))
        
        button.addSubview(pencil)
        button.addSubview(label)
        button.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        pencil.translatesAutoresizingMaskIntoConstraints = false
        pencil.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pencil.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(container)
        container.addSubview(topView)
        topView.addSubview(profileImage)
        topView.addSubview(nameAndEmailTextView)
        topView.addSubview(separator)
        
        container.frame = view.frame
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor, constant: -30),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 400),
            
            profileImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100),
            profileImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            nameAndEmailTextView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15),
            nameAndEmailTextView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            nameAndEmailTextView.heightAnchor.constraint(equalToConstant: 70),
            nameAndEmailTextView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            separator.topAnchor.constraint(equalTo: nameAndEmailTextView.bottomAnchor, constant: 50),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            separator.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
