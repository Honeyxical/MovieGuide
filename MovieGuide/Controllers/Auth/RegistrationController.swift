import UIKit

class RegistrationController: UIViewController {
    let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(nil, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    @objc private func back(){
        navigationController?.popViewController(animated: true)
    }
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: "Personal details",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: .bold)])
        return label
    }()
    
    private let nicknameTF: UITextField = getTextField(plaseholder: "Nickname")
    
    private let email: UITextField = getTextField(plaseholder: "Email")
    
    private let loginTF: UITextField = getTextField(plaseholder: "Login")
    
    private let passwordTF: UITextField = getTextField(plaseholder: "Password")
    
    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setAttributedTitle(NSAttributedString(
            string: "SIGN UP",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!]), for: .normal)
        btn.backgroundColor = .black
        btn.addTarget(nil, action: #selector(registrationButton), for: .touchUpInside)
        return btn
    }()
    
    @objc private func registrationButton() {
        if nicknameTF.text! == "" || loginTF.text! == "" || passwordTF.text! == "" {
            self.present(getAllert(message: "Field nickname, login or password is empty"), animated: true)
        }
        let currentUser = User(nickname: nicknameTF.text!, email: email.text!, login: loginTF.text!, password: passwordTF.text!, userHash: hashValue)
        if userService.registration(user: currentUser){
            self.navigationController?.pushViewController(TabBarController(networkService: NetworkService(),
                                                                           userService: UserService(userStotage: UserDefaultsBaseManager(), user: currentUser),
                                                                           user: currentUser), animated: true)
            self.navigationController?.navigationBar.isHidden = true
        } else {
            self.present(getAllert(message: "Account already exist"), animated: true)

        }
    }
    
    private let haveACLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(
            string: "Already have an account?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!])
        return label
    }()
    
    private let signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setAttributedTitle(NSAttributedString(
            string: "Sign In",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]), for: .normal)
        btn.addTarget(nil, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        
        nicknameTF.delegate = self
        loginTF.delegate = self
        email.delegate = self
        passwordTF.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(backButton)
        view.addSubview(registerLabel)
        view.addSubview(nicknameTF)
        view.addSubview(loginTF)
        view.addSubview(email)
        view.addSubview(passwordTF)
        view.addSubview(registerButton)
        view.addSubview(haveACLabel)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            
            registerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
            registerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            nicknameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 225),
            nicknameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nicknameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            email.topAnchor.constraint(equalTo: nicknameTF.bottomAnchor, constant: 60),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            loginTF.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 60),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 60),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            haveACLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            haveACLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -33),
            haveACLabel.heightAnchor.constraint(equalToConstant: 20),
            
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            signInButton.leadingAnchor.constraint(equalTo: haveACLabel.trailingAnchor, constant: 2),
            signInButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}

extension RegistrationController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
