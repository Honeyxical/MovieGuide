import UIKit

class AuthController: UIViewController {

    private let buttonLogin: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.addTarget(nil, action: #selector(login), for: .touchUpInside)
        return button
    }()
    @objc private func login() {
        navigationController?.pushViewController(LoginController(), animated: true)
    }
    
    private let buttonRegistration: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registration", for: .normal)
        button.addTarget(nil, action: #selector(registration), for: .touchUpInside)
        return button
    }()
    @objc private func registration() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(buttonLogin)
        view.addSubview(buttonRegistration)
        
        NSLayoutConstraint.activate([
            buttonLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogin.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
            buttonLogin.heightAnchor.constraint(equalToConstant: 35),
            buttonLogin.widthAnchor.constraint(equalToConstant: 200),
            
            buttonRegistration.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonRegistration.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            buttonRegistration.heightAnchor.constraint(equalToConstant: 35),
            buttonRegistration.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}
