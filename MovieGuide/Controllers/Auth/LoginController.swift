import UIKit

class LoginController: UIViewController {
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Login"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    private let loginTF: UITextField = getTextField(plaseholder: "Login")
    
    private let passwordTF: UITextField = getTextField(plaseholder: "Password")
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setAttributedTitle(NSAttributedString(
            string: "LOGIN",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!]), for: .normal)
        btn.backgroundColor = .black
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
    
    private let restorePassword: UIButton = {
        let restore = UIButton(type: .system)
        restore.translatesAutoresizingMaskIntoConstraints = false
        restore.setAttributedTitle(NSAttributedString(
            string: "Forgot your password?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!]), for: .normal)
        return restore
    }()
    
    private let facebookLogin: UIButton = {
        let fb = UIButton(type: .system)
        fb.translatesAutoresizingMaskIntoConstraints = false
        fb.setAttributedTitle(NSAttributedString(
            string: "LOGIN WITH FACEBOOK",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!]), for: .normal)
        fb.backgroundColor = .white
        fb.layer.borderWidth = 1
        fb.layer.borderColor = UIColor.blue.cgColor
        return fb
    }()
    
    private let createACLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: "Don't have an account?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!])
        return label
    }()
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setAttributedTitle(NSAttributedString(
            string: "Sign Up",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]), for: .normal)
        btn.addTarget(nil, action: #selector(signUp), for: .touchUpInside)
        return btn
    }()
    
    @objc private func signUp() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        
        loginTF.text = "Q"
        passwordTF.text = "Q"
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setupLayout() {
        view.addSubview(loginLabel)
        view.addSubview(loginTF)
        view.addSubview(passwordTF)
        view.addSubview(loginButton)
        view.addSubview(restorePassword)
        view.addSubview(facebookLogin)
        view.addSubview(createACLabel)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            loginTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 285),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 60),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            restorePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restorePassword.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            restorePassword.heightAnchor.constraint(equalToConstant: 20),
            
            facebookLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            facebookLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            facebookLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            facebookLogin.heightAnchor.constraint(equalToConstant: 50),
            
            createACLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            createACLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -33),
            createACLabel.heightAnchor.constraint(equalToConstant: 20),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            signUpButton.leadingAnchor.constraint(equalTo: createACLabel.trailingAnchor, constant: 2),
            signUpButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
