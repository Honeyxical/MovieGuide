import UIKit

class FilmDescriptionController: UIViewController {
    
    let film: FilmFullInfo = getFilmMocks()
    
    private let navigationBar: UIView = {
        let navBar = UIView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 400)
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let filmsParamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2019, боевик, драма, комедия, 1 сезон \nСША, 30 мин, 18+"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "В ролях: Ами Косимидзу, Ая Судзаки, Тосихико Сэки, Синъитиро Мики ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        attributedText.append(NSAttributedString(string: "и другие", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .bold)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let controllStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        stack.layer.borderWidth = 1
        return stack
    }()
    
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.maximumNumberOfLines = 7
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 14)
        textView.text = "Home is where we feel comfortable, safe, and loved. It's a place where we create memories with our family and friends. Home can be a physical structure or a feeling. It's where we relax, recharge, and find solace from the outside world. We decorate it with our personal items, fill it with the scents of home-cooked meals, and make it our own. Home is not just a place; it's a sense of belonging, a sanctuary from the chaos of life, and a reflection of who we are."
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSrollLayout()
    }
    
    private func setupSrollLayout() {
        let imageViewContainer = UIView()
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "FilmTitle"
        
//        navigationBar.addSubview(title)
        
        view.addSubview(scrollView)
//        view.addSubview(navigationBar)
        
        scrollView.addSubview(imageViewContainer)
        scrollView.addSubview(filmsParamLabel)
        scrollView.addSubview(actorsLabel)
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(controllStackView)
        scrollView.addSubview(imageViewContainer)
        
        imageViewContainer.addSubview(imageView)
        
        NSLayoutConstraint.activate([
//            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            navigationBar.heightAnchor.constraint(equalToConstant: 50),
            
//            title.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
//            title.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
//
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imageViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewContainer.heightAnchor.constraint(equalToConstant: 670),
            
            imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 470),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            filmsParamLabel.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 10),
            filmsParamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            filmsParamLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            filmsParamLabel.heightAnchor.constraint(equalToConstant: 50),
            
            actorsLabel.topAnchor.constraint(equalTo: filmsParamLabel.bottomAnchor),
            actorsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            actorsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            actorsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            controllStackView.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: 10),
            controllStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controllStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controllStackView.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionTextView.topAnchor.constraint(equalTo: controllStackView.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
