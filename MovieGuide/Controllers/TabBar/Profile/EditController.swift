import UIKit

class EditController: UIViewController {
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton(type: .system)
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(nil, action: #selector(backButtonHandler), for: .touchUpInside)
        
        let title = UILabel()
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Edit profile"
        title.textColor = .black
        
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    @objc private func backButtonHandler() {
        navigationController?.popViewController(animated: true)
    }
    
    private let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Ghost"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 100
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var editNicknameField = getField(placeholder: "Nickname")
    
    private lazy var editEmailField = getField(placeholder: "Email")
    
    private lazy var editPasswordField = getField(placeholder: "Password")
   
    private lazy var repeatPasswordField = getField(placeholder: "Repeat password")
    
    private lazy var stackFiled: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [editNicknameField, editEmailField, editPasswordField, repeatPasswordField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fill
        return stack
    }()
    
    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save", for: .normal)
        btn.addTarget(nil, action: #selector(saveHandler), for: .touchUpInside)
        btn.layer.cornerRadius = 30
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    @objc private func saveHandler() {
        if editPasswordField.text == repeatPasswordField.text || (editPasswordField.text == "" && repeatPasswordField.text == "") {
            if let user = Auth.auth.getCurrentUser(){
                user.dataEditing(tuple: (nickName: editNicknameField.text!, email: editEmailField.text!, password: editPasswordField.text!))
                Auth.auth.saveCurrentUser(user: user)
                navigationController?.popViewController(animated: true)
            }
        } else {
            self.present(getAllert(message: "Passwords don't match "), animated: true)
        }
    }
    
    private let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cancel", for: .normal)
        btn.addTarget(nil, action: #selector(backButtonHandler), for: .touchUpInside)
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1.5
        btn.layer.cornerRadius = 30
        btn.tintColor = .black
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(image)
        view.addSubview(stackFiled)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),
            
            image.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 25),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            stackFiled.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
            stackFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cancelButton.heightAnchor.constraint(equalToConstant: 70),
            cancelButton.widthAnchor.constraint(equalToConstant: 170),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 70),
            saveButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func getField(placeholder: String) -> UITextField{
        
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.cornerRadius = 15
        let textPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        tf.leftView = textPaddingView
        tf.leftViewMode = .always
        
        NSLayoutConstraint.activate([
            tf.heightAnchor.constraint(equalToConstant: 60),
            tf.widthAnchor.constraint(equalToConstant: view.bounds.width)
        ])
        
        return tf
    }
}
