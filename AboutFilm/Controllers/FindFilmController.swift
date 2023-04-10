import UIKit

class FindFilmController: UIViewController {

    
    @IBAction func btn(_ sender: UIButton) {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmDescriptionController")
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
