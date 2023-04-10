import UIKit

class LaunchScreenViewController: UIViewController {

    private let network = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmsController") as! FilmsController
        DispatchQueue.main.async {
            self.network.getFilms { docs in
                destination.films = docs
            }
        }
    }

}
