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
    
    //MARK: - Button for stack
    
    private let buttonLike: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Star"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    private let buttonBookMark: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Favourite"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    private let buttonShare: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Share"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.maximumNumberOfLines = 7
        textView.isSelectable = false
        textView.isEditable = false
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 16)
        textView.text = "Home is where we feel comfortable, safe, and loved. It's a place where we create memories with our family and friends. Home can be a physical structure or a feeling. It's where we relax, recharge, and find solace from the outside world. We decorate it with our personal items, fill it with the scents of home-cooked meals, and make it our own. Home is not just a place; it's a sense of belonging, a sanctuary from the chaos of life, and a reflection of who we are."
        return textView
    }()
    
    private lazy var ratingScrollView: UIScrollView = {
        let rating = UIScrollView()
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        return rating
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSrollLayout()
        setupRatingScrollView()
    }
    
    private func setupSrollLayout() {
        let imageViewContainer = UIView()
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "FilmTitle"
        
        let controllStackView = UIStackView(arrangedSubviews: [buttonLike, buttonBookMark, buttonShare])
        controllStackView.translatesAutoresizingMaskIntoConstraints = false
        controllStackView.axis = .horizontal
        controllStackView.distribution = .fillEqually
        
        navigationBar.addSubview(title)
        
        view.addSubview(scrollView)
        view.addSubview(navigationBar)
        
        scrollView.addSubview(imageViewContainer)
        scrollView.addSubview(filmsParamLabel)
        scrollView.addSubview(actorsLabel)
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(controllStackView)
        scrollView.addSubview(ratingScrollView)
        
        scrollView.addSubview(imageViewContainer)
    
        
        imageViewContainer.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50),
            
            title.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
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
            controllStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            controllStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            controllStackView.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionTextView.topAnchor.constraint(equalTo: controllStackView.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            ratingScrollView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            ratingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ratingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ratingScrollView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    

//MARK: - Setup Scroll Rating
    
    private func setupRatingScrollView() {
        
        let vote: UIView = {
            let vote = UIView()
            let numLabel = UILabel()
            let descLabel = UILabel()
            
            vote.addSubview(numLabel)
            vote.addSubview(descLabel)
            
            vote.translatesAutoresizingMaskIntoConstraints = false
            numLabel.translatesAutoresizingMaskIntoConstraints = false
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            
            vote.backgroundColor = .mainGray

            
            numLabel.text = "9.0"
            numLabel.font = .boldSystemFont(ofSize: 30)
            
            descLabel.text = "Rating IMDb"
            descLabel.font = .systemFont(ofSize: 16)
            descLabel.numberOfLines = 2
            
            NSLayoutConstraint.activate([
                numLabel.topAnchor.constraint(equalTo: vote.topAnchor),
                numLabel.leadingAnchor.constraint(equalTo: vote.leadingAnchor, constant: 20),
                numLabel.bottomAnchor.constraint(equalTo: vote.bottomAnchor),
                numLabel.widthAnchor.constraint(equalToConstant: 70),
                
                descLabel.topAnchor.constraint(equalTo: vote.topAnchor),
                descLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor),
                descLabel.trailingAnchor.constraint(equalTo: vote.trailingAnchor),
                descLabel.bottomAnchor.constraint(equalTo: vote.bottomAnchor)
            ])
            return vote
        }()
        
        let vote2: UIView = {
            let vote = UIView()
            let numLabel = UILabel()
            let descLabel = UILabel()
            
            vote.addSubview(numLabel)
            vote.addSubview(descLabel)
            
            vote.translatesAutoresizingMaskIntoConstraints = false
            numLabel.translatesAutoresizingMaskIntoConstraints = false
            descLabel.translatesAutoresizingMaskIntoConstraints = false
            
            vote.backgroundColor = .mainGray

            
            numLabel.text = "9.0"
            numLabel.font = .boldSystemFont(ofSize: 30)
            
            descLabel.text = "Rating IMDb"
            descLabel.font = .systemFont(ofSize: 16)
            descLabel.numberOfLines = 2
            
            NSLayoutConstraint.activate([
                numLabel.topAnchor.constraint(equalTo: vote.topAnchor),
                numLabel.leadingAnchor.constraint(equalTo: vote.leadingAnchor, constant: 20),
                numLabel.bottomAnchor.constraint(equalTo: vote.bottomAnchor),
                numLabel.widthAnchor.constraint(equalToConstant: 70),
                
                descLabel.topAnchor.constraint(equalTo: vote.topAnchor),
                descLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor),
                descLabel.trailingAnchor.constraint(equalTo: vote.trailingAnchor),
                descLabel.bottomAnchor.constraint(equalTo: vote.bottomAnchor)
            ])
            return vote
        }()
        
        ratingScrollView.addSubview(vote)
        ratingScrollView.addSubview(vote2)
        
        NSLayoutConstraint.activate([
            vote.topAnchor.constraint(equalTo: ratingScrollView.topAnchor),
            vote.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            vote.bottomAnchor.constraint(equalTo: ratingScrollView.bottomAnchor),
            vote.widthAnchor.constraint(equalToConstant: 200),
            vote.heightAnchor.constraint(equalToConstant: 100),
            
            vote2.topAnchor.constraint(equalTo: ratingScrollView.topAnchor),
            vote2.leadingAnchor.constraint(equalTo: vote.trailingAnchor, constant: 15),
            vote2.bottomAnchor.constraint(equalTo: ratingScrollView.bottomAnchor),
            vote2.heightAnchor.constraint(equalToConstant: 100),
            vote2.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    
}
