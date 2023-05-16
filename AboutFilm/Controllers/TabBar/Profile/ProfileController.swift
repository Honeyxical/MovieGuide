import UIKit

class ProfileController: UIViewController {
    let user = Auth.auth.getCurrentUser()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
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
        
        guard let user = user else { return text }
        
        let attributedText = NSMutableAttributedString(string: user.nickname, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)])
        attributedText.append(NSAttributedString(string: "\n" + user.email, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .thin), NSAttributedString.Key.paragraphStyle: titleParagraphStyle]))
        
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
        let pencil = UIImageView(image: UIImage(named: "pencil"))
        let label = UILabel()
        label.text = "Edit profile"
        
        button.addSubview(pencil)
        button.addSubview(label)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(openEdit), for: .touchUpInside)

        label.translatesAutoresizingMaskIntoConstraints = false

        pencil.translatesAutoresizingMaskIntoConstraints = false
        pencil.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pencil.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        NSLayoutConstraint.activate([
            pencil.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            pencil.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: pencil.trailingAnchor, constant: 15)
        ])
        
        return button
    }()

    @objc private func openEdit(){
        navigationController?.pushViewController(EditController(), animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    private lazy var stackButtons: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favoriteBtn, aboutBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        stack.layer.cornerRadius = 15
        stack.axis = .vertical
        return stack
    }()
    
    private let favoriteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(nil, action: #selector(openFavorite), for: .touchUpInside)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favorite"
        
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .gray
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        
        btn.addSubview(label)
        btn.addSubview(image)
        btn.addSubview(separator)
        
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 60),
            
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 25),
            
            image.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            image.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -15),
            
            separator.bottomAnchor.constraint(equalTo: btn.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 25),
            separator.trailingAnchor.constraint(equalTo: btn.trailingAnchor)
        ])
        return btn
    }()
    
    @objc private func openFavorite() {
        navigationController?.pushViewController(FavoriteController(), animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    private let aboutBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(nil, action: #selector(openAbout), for: .touchUpInside)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About us"
        
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .gray
        
        btn.addSubview(label)
        btn.addSubview(image)
        
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 60),
            
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: btn.leadingAnchor, constant: 25),
            
            image.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            image.trailingAnchor.constraint(equalTo: btn.trailingAnchor, constant: -15)
        ])
        return btn
    }()
    
    @objc private func openAbout() {
        navigationController?.pushViewController(AboutController(), animated: true)
        navigationController?.navigationBar.isHidden = false
    }
   
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
        topView.addSubview(editButton)
        view.addSubview(stackButtons)
        
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
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            editButton.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 7),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackButtons.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 35),
            stackButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
}
