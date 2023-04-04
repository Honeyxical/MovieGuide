//
//  testViewController.swift
//  AboutFilm
//
//  Created by илья on 04.04.23.
//

import UIKit

class FilmsController: UIViewController {

    var name = ""
    
    @IBOutlet weak var greetingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greetingsLabel.text!.append(name)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
