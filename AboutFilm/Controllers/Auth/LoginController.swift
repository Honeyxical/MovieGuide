//
//  LoginController.swift
//  AboutFilm
//
//  Created by илья on 04.04.23.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if loginTF.text! == "" || passwordTF.text! == ""{
            self.present(getAllert(message: "Field login or password are empty"), animated: true)
            return
        }
        guard let _ = Auth().login(userLogin: loginTF.text!, userPassword: passwordTF.text!) else {
            self.present(getAllert(message: "User not found"), animated: true)
            return
        }
        
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationController?.pushViewController(destination, animated: true)
        
    }
    
}
