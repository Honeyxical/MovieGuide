import UIKit

class RegistrationController: UIViewController {
    private let nicknameTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nickname"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    private let loginTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Login"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    
    private let passwordTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Registration", for: .normal)
        btn.addTarget(nil, action: #selector(registrationButton), for: .touchUpInside)
        return btn
    }()
    
    @objc private func registrationButton() {
        if nicknameTF.text! == "" || loginTF.text! == "" || passwordTF.text! == "" {
            self.present(getAllert(message: "Field nickname, login or password is empty"), animated: true)
        }
        if Auth().registration(user: User(nickname: nicknameTF.text!, login: loginTF.text!, password: passwordTF.text!, userHash: hashValue)){
            self.navigationController?.pushViewController(TabBarController(), animated: true)
            self.navigationController?.navigationBar.isHidden = true
        }else{
            self.present(getAllert(message: "Account already exist"), animated: true)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(nicknameTF)
        view.addSubview(loginTF)
        view.addSubview(passwordTF)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            nicknameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 375),
            nicknameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nicknameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            loginTF.topAnchor.constraint(equalTo: nicknameTF.bottomAnchor, constant: 10),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 10),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
}
