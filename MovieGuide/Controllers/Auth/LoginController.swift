import UIKit

class LoginController: UIViewController {
    
    private let loginTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Login"
        tf.text = "E"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    
    private let passwordTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.text = "E"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = false
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Login", for: .normal)
        btn.addTarget(nil, action: #selector(login), for: .touchUpInside)
        return btn
    }()
    
    @objc private func login() {
        if loginTF.text! == "" || passwordTF.text! == ""{
            self.present(getAllert(message: "Field login or password are empty"), animated: true)
            return
        }
        if !Auth().login(userLogin: loginTF.text!, userPassword: passwordTF.text!){
            self.present(getAllert(message: "User not found"), animated: true)
            return
        }
        self.navigationController?.pushViewController(TabBarController(), animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(loginTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 385),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 10),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
