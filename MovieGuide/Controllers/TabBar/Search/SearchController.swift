import UIKit

class SearchController: UIViewController {
    let networkService: NetworkServiceProtocol
    var findTextFiled = UITextField()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        findTextFiled = configureFindTextFiled()
        
        view.addSubview(getFindTextFieldView())
    }
    
    private func getFindTextFieldView() -> UIView {
        let view = UIView(frame: CGRect(x: 15, y: 65, width: 363, height: 60))
        view.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 5
        view.addSubview(configureFindTextFiled())
        view.addSubview(getMagnifyingglass())
        return view
    }
    
    private func configureFindTextFiled() -> UITextField {
        let findTextFiled = UITextField(frame: CGRect(x: 40, y: 14, width: 300, height: 31))
        findTextFiled.delegate = self
        findTextFiled.placeholder = "Films, serials, anime"
        findTextFiled.attributedPlaceholder = NSAttributedString(string: "Films, serials, anime",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        findTextFiled.clearButtonMode = .whileEditing
        return findTextFiled
    }
    
    private func getMagnifyingglass() -> UIImageView {
        let magnifyingglass = UIImageView(frame: CGRect(x: 15, y: 20, width: 20, height: 20))
        magnifyingglass.image = UIImage(systemName: "magnifyingglass")
        magnifyingglass.tintColor = UIColor.gray
        return magnifyingglass
    }
    
}

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let destination = SearchResultController()

        networkService.searchFilm(name: textField.text!) { data in
            destination.films = data
        }
        destination.navbarTitle += textField.text!

        self.navigationController?.pushViewController(destination, animated: true)
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
