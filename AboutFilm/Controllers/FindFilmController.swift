import UIKit

class FindFilmController: UIViewController, UITextFieldDelegate {
    let network = NetworkService()
    var findTextFiled = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findTextFiled = configureFindTextFiled()
        
        view.addSubview(getFindTextFieldView())
    }
    
    private func getFindTextFieldView() -> UIView{
        let view = UIView(frame: CGRect(x: 15, y: 65, width: 363, height: 60))
        view.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 5
        view.addSubview(configureFindTextFiled())
        view.addSubview(getMagnifyingglass())
        return view
    }
    
    private func configureFindTextFiled() -> UITextField{
        let findTextFiled = UITextField(frame: CGRect(x: 40, y: 14, width: 300, height: 31))
        findTextFiled.delegate = self
        findTextFiled.placeholder = "Films, serials, anime"
        findTextFiled.attributedPlaceholder = NSAttributedString(string: "Films, serials, anime", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        findTextFiled.clearButtonMode = .whileEditing
        return findTextFiled
    }
    
    private func getMagnifyingglass() ->UIImageView{
        let magnifyingglass = UIImageView(frame: CGRect(x: 15, y: 20, width: 20, height: 20))
        magnifyingglass.image = UIImage(systemName: "magnifyingglass")
        magnifyingglass.tintColor = UIColor.gray
        return magnifyingglass
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultController") as! SearchResultController
        
        network.searchFilm(name: textField.text!) { data in
            destination.films = data
        }
        destination.navbarTitle += textField.text!

        self.navigationController?.pushViewController(destination, animated: true)
        return true
    }
    
}

