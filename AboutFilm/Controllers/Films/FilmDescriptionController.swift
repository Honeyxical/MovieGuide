import UIKit

class FilmDescriptionController: UIViewController {
    
    var film: FilmFullInfo? {
        didSet{
            guard let film = film else {
                return
            }
            DispatchQueue.main.async { [self] in
                loader.removeFromSuperview()
                
//                imageView.image = UIImage(data: (film.poster?.posterData))
                
                filmsParamLabel.text = "\(String(film.year!)), \(genresToString(array: film.genres!, count: 3)) \n\(film.countries![0].name!), \(film.movieLength ?? 0) мин, \(film.ageRating ?? 6)+"
                
                if film.description == nil {
                    descriptionTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    scrollView.contentSize.height -= 105
                }else {
                    descriptionTextView.text = film.description!
                }
                
                if film.rating!.await != 0 || film.rating!.filmCritics != 0 || film.rating!.imdb != 0 || film.rating!.kp != 0 || film.rating!.russianFilmCritics != 0 {
                    ratingStackView = getStackView(arrangedSubviews: getRatingArray(rating: film.rating!))

                } else {
                    ratingScrollView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    ratingLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    scrollView.contentSize.height -= 140
                }
                
                if film.persons!.isEmpty {
                    actorLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    actorsCollection.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    actorsCounter.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    actorsListLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    scrollView.contentSize.height -= 430
                } else {
                    let rolesAttributedString = NSMutableAttributedString(string: "В ролях: \(actorsToString(array: film.persons!, count: 3))", attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
                        NSAttributedString.Key.foregroundColor: UIColor.systemGray])
                    
                    rolesAttributedString.append(NSAttributedString(string: " и другие", attributes: [
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .bold),
                        NSAttributedString.Key.foregroundColor : UIColor.gray
                    ]))
                    
                    actorsListLabel.attributedText = rolesAttributedString
                    
                    actorsCounter.text = String(film.persons!.count)

                }
                
                if film.similarMovies!.isEmpty {
                    relatedMoviesLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    relatedMoviesScroll.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    relatedMoviesCounter.heightAnchor.constraint(equalToConstant: 0).isActive = true
                } else {
                    relatedMoviesCounter.text = String(film.similarMovies!.count)
                    relatedMoviesStack = getStackView(arrangedSubviews: getMoviesArray(array: film.similarMovies!))
                    scrollView.contentSize.height += 350
                }
                setupScrollLayout()
            }
        }
    }
    
    private let navigationBar: UIView = {
        let navBar = UIView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private lazy var navBarTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FilmTitle"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 950)
        return scrollView
    }()
    
    private lazy var imageViewContainer: UIView = {
        let imageViewContainer = UIImageView(image: imageView.image)
        imageViewContainer.addSubview(Loader.loader.getBlur(for: imageViewContainer, style: .extraLight))
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        return imageViewContainer
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    //MARK: - filmsParamLabel
    
    private let filmsParamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    //MARK: - actorsListLabel
    
    private let actorsListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Buttons for stack
    
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
    
    //MARK: - Description text view
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.maximumNumberOfLines = 7
        textView.isSelectable = false
        textView.isEditable = false
        textView.textAlignment = .left
        return textView
    }()
    
    //MARK: - Rating view
    private lazy var ratingLabel = getLabel(text: "Rating")
    private lazy var ratingScrollView: UIScrollView = getScrollView()
    private lazy var ratingStackView: UIStackView = getStackView(arrangedSubviews: [])
    
    //MARK: - Actors view
    
    private lazy var actorLabel = getLabel(text: "Actors")
    private lazy var actorsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isEditing = false
        collection.isPagingEnabled = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    //MARK: - Posters view
    private lazy var posterLabel = getLabel(text: "Posters")
    private lazy var posterScrollView: UIScrollView = getScrollView()
    private lazy var posterStackView: UIStackView = getStackView(arrangedSubviews: [getImage(),getImage(),getImage()])
    
    //MARK: - Counters
    
    private lazy var actorsCounter = getCounter(count: "89")
    private lazy var imageCounter = getCounter(count: "89")
    
    //MARK: - Related movies label
    
    private lazy var relatedMoviesLabel: UILabel = getLabel(text: "Similar movies")
    private lazy var relatedMoviesCounter: UILabel = getCounter(count: "89")
    
    //MARK: - Related movies view
    
    private lazy var relatedMoviesScroll: UIScrollView = getScrollView()
    private lazy var relatedMoviesStack: UIStackView = getStackView(arrangedSubviews: [])
    
    //MARK: - viewDidLoad
    
    private let loader = Loader.getLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loader)
        configureLoader()
        
        NetworkService.network.getRandomFilm { film in
            self.film = film
        }
        
//        film = getFilmMocks()
        
        actorsCollection.register(ActorCell.self, forCellWithReuseIdentifier: "Item")
        actorsCollection.dataSource = self
    }
    
    private func configureLoader() {
        loader.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        loader.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        scrollView.isScrollEnabled = false
    }
    
    //MARK: - setupScrollLayout
    
    private func setupScrollLayout() {
        
        let controllStackView = UIStackView(arrangedSubviews: [buttonLike, buttonBookMark, buttonShare])
        controllStackView.translatesAutoresizingMaskIntoConstraints = false
        controllStackView.axis = .horizontal
        controllStackView.distribution = .fillEqually
        
        view.addSubview(scrollView)
        view.addSubview(navigationBar)
        
        navigationBar.addSubview(navBarTitle)
        
        
        scrollView.addSubview(imageViewContainer)
        scrollView.addSubview(filmsParamLabel)
        scrollView.addSubview(actorsListLabel)
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(controllStackView)
        scrollView.addSubview(ratingLabel)
        scrollView.addSubview(ratingScrollView)
        scrollView.addSubview(actorLabel)
        scrollView.addSubview(actorsCounter)
        scrollView.addSubview(actorsCollection)
        scrollView.addSubview(posterLabel)
        scrollView.addSubview(imageCounter)
        scrollView.addSubview(posterScrollView)
        scrollView.addSubview(relatedMoviesLabel)
        scrollView.addSubview(relatedMoviesCounter)
        scrollView.addSubview(relatedMoviesScroll)
            
        imageViewContainer.addSubview(imageView)
        
        setupScrollView(scrollView: ratingScrollView, stackView: ratingStackView)
        setupScrollView(scrollView: posterScrollView, stackView: posterStackView)
        setupScrollView(scrollView: relatedMoviesScroll, stackView: relatedMoviesStack)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 50),

            navBarTitle.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            navBarTitle.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
//
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imageViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -60),
            imageViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewContainer.heightAnchor.constraint(equalToConstant: 770),
            
            imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 470),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            filmsParamLabel.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 15),
            filmsParamLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            filmsParamLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            filmsParamLabel.heightAnchor.constraint(equalToConstant: 50),
            
            actorsListLabel.topAnchor.constraint(equalTo: filmsParamLabel.bottomAnchor),
            actorsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            actorsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            actorsListLabel.heightAnchor.constraint(equalToConstant: 50),
            
            controllStackView.topAnchor.constraint(equalTo: actorsListLabel.bottomAnchor, constant: 10),
            controllStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            controllStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            controllStackView.heightAnchor.constraint(equalToConstant: 60),
            
            descriptionTextView.topAnchor.constraint(equalTo: controllStackView.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 105),
            
            ratingLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 15),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            ratingScrollView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 15),
            ratingScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ratingScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ratingScrollView.heightAnchor.constraint(equalToConstant: 100),
            
            actorLabel.topAnchor.constraint(equalTo: ratingScrollView.bottomAnchor, constant: 15),
            actorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            actorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            actorsCounter.topAnchor.constraint(equalTo: ratingScrollView.bottomAnchor, constant: 15),
            actorsCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            actorsCounter.heightAnchor.constraint(equalToConstant: 40),

            actorsCollection.topAnchor.constraint(equalTo: actorLabel.bottomAnchor, constant: 15),
            actorsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actorsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actorsCollection.heightAnchor.constraint(equalToConstant: 340),
            
            posterLabel.topAnchor.constraint(equalTo: actorsCollection.bottomAnchor, constant: 15),
            posterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            posterLabel.heightAnchor.constraint(equalToConstant: 40),

            imageCounter.topAnchor.constraint(equalTo: actorsCollection.bottomAnchor, constant: 15),
            imageCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imageCounter.heightAnchor.constraint(equalToConstant: 40),
            
            posterScrollView.topAnchor.constraint(equalTo: posterLabel.bottomAnchor, constant: 15),
            posterScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterScrollView.heightAnchor.constraint(equalToConstant: 150),
            
            relatedMoviesLabel.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 15),
            relatedMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            relatedMoviesLabel.heightAnchor.constraint(equalToConstant: 40),
            
            relatedMoviesCounter.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 15),
            relatedMoviesCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            relatedMoviesCounter.heightAnchor.constraint(equalToConstant: 40),
            
            relatedMoviesScroll.topAnchor.constraint(equalTo: relatedMoviesLabel.bottomAnchor, constant: 15),
            relatedMoviesScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            relatedMoviesScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            relatedMoviesScroll.heightAnchor.constraint(equalToConstant: 310)
            
        ])
    }
    
    //MARK: - setupScrollView
    
    private func setupScrollView(scrollView: UIScrollView, stackView: UIStackView) {
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - getStackView
    
    private func getStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 15
        return stack
    }
    
    //MARK: - getScrollView
    
    private func getScrollView() -> UIScrollView {
        let rating = UIScrollView()
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.showsHorizontalScrollIndicator = false
        return rating
    }
    
    //MARK: - getLabel
    
    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.labelFont
        return label
    }
    
    //MARK: - getCounter
    
    private func getCounter(count: String) -> UILabel {
        let counter = UILabel()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.text = count
        counter.textAlignment = .right
        counter.textColor = .counterColor
        counter.font = .labelFont
        return counter
    }
    
    //MARK: - getImage
    
    private func getImage() -> UIImageView {
        let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        return image
    }
    
    private func getScrollViewHeightSize() -> CGFloat{
         let number = imageViewContainer.frame.height + filmsParamLabel.frame.height + actorsListLabel.frame.height + 40 + descriptionTextView.frame.height + 40 + ratingScrollView.frame.height + actorsCounter.frame.height + actorsCollection.frame.height + imageCounter.frame.height + posterScrollView.frame.height + relatedMoviesLabel.frame.height + relatedMoviesScroll.frame.height
        
        print(number)
        return number
    }
    
}

extension FilmDescriptionController: UICollectionViewDataSource {
    
    func collectionLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 100)
        layout.minimumLineSpacing = 20
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ActorCell
        
        guard let person = film?.persons![indexPath.item] else {
            return cell
        }
    
        cell.person = person
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = film?.persons!.count else {
            return 0
        }
        return count
    }

}
