import UIKit

class FilmController: UIViewController {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var filmId: Int = 0
    var backButtonIsHidden = true
    var updateButtonIsHidden = false

    private var user = Auth.auth.getCurrentUser()

    var film: FilmFullInfo? {
        didSet {
            guard let film = film, let filmId = film.id else {
                return
            }
            setFilmPoster()
            setPosters(id: filmId)

            DispatchQueue.main.async { [self] in
                actorsCollection.reloadData()

                updatebutton.isEnabled = true
                scrollView.isScrollEnabled = true
                self.loader.removeFromSuperview()

                if film.name != "" && film.name != nil {
                    filmTitleLabel.text = film.enName ?? film.name!
                } else {
                    filmTitleLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    scrollView.contentSize.height -= 60
                }

                filmsParamLabel.text = "\(String(film.year!)), \(genresToString(array: film.genres!, count: 3)) \n\(film.countries![0].name!), \(film.movieLength ?? 0) мин, \(film.ageRating ?? 6)+"

                if film.description == nil {
                    descriptionTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    scrollView.contentSize.height -= 105
                 } else {
                    descriptionTextView.text = film.description!
                }

                if film.rating != nil {
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
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                        NSAttributedString.Key.foregroundColor: UIColor.systemGray])

                    rolesAttributedString.append(NSAttributedString(string: " и другие", attributes: [
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold),
                        NSAttributedString.Key.foregroundColor: UIColor.gray
                    ]))

                    actorsListLabel.attributedText = rolesAttributedString

                    actorsCounter.text = String(film.persons!.count)

                }
                setSimilarMovieImage()
                setupScrollLayout()
            }
        }
    }

    private let navigationBar: UIView = {
        let navBar = UIView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()

    private let navBarTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    // MARK: - backButton

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
        button.isHidden = backButtonIsHidden
        return button
    }()

    @objc private func backButtonHandler() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - updateButton

    private lazy var updatebutton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(updatebuttonHandler), for: .touchUpInside)
        button.isHidden = updateButtonIsHidden
        return button
    }()

    @objc private func updatebuttonHandler() {
        updatebutton.isEnabled = false
        ratingStackView.removeFromSuperview()
        imageViewContainer.image = UIImage(named: "PlaceholderImage")
        imageView.image = UIImage(named: "PlaceholderImage")
        actorsCollection.removeFromSuperview()
        posterStackView.removeFromSuperview()
        posterStackView = getStackView(arrangedSubviews: [])
        similarMoviesStack.removeFromSuperview()
        similarMoviesStack = getStackView(arrangedSubviews: [])
        print(similarMoviesStack)
        scrollView.removeFromSuperview()
        scrollView.scrollToTop()

        view.addSubview(loader)

        networkService.getRandomFilm { film in
            self.film = film
        }

        scrollView.contentSize.height = view.frame.height + 1050
    }

    // MARK: - scrollView

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 1020)
        return scrollView
    }()

    // MARK: - imageViewContainer

    private lazy var imageViewContainer: UIImageView = {
        let imageViewContainer = UIImageView(image: UIImage(named: "PlaceholderImage"))
        imageViewContainer.contentMode = .scaleAspectFill
        imageViewContainer.addSubview(Loader.getBlur(for: imageViewContainer, style: .light))
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        return imageViewContainer
    }()

    // MARK: - imageView

    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "PlaceholderImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()

    // MARK: - filmTitleLabel

    private let filmTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .labelFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - filmsParamLabel

    private let filmsParamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()

    // MARK: - actorsListLabel

    private let actorsListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    // MARK: - Buttons for stack

    private let buttonLike: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Star"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    private lazy var buttonBookMark: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let filmId = filmId > 0 ? filmId : film!.id!
        let stateImage = user!.getFavouritesFilms().contains(filmId) ? "FavouriteAdded" : "Favourite"
        button.setImage(UIImage(named: stateImage), for: .normal)
        button.tintColor = .systemGray2
        button.addTarget(nil, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()

    @objc private func addToFavorite() {
        guard let user = user else { return }
        let filmId = filmId > 0 ? filmId : film!.id!
        if !user.getFavouritesFilms().contains(filmId) {
            user.addFavouriteFilm(filmId: filmId, user: user)
            buttonBookMark.setImage(UIImage(named: "FavouriteAdded"), for: .normal)
        } else {
            user.removeFavouriteFilm(filmId: filmId, user: user)
            buttonBookMark.setImage(UIImage(named: "Favourite"), for: .normal)

        }
    }

    private let buttonShare: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Share"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()

    // MARK: - Description text view

    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.maximumNumberOfLines = 7
        textView.isSelectable = false
        textView.isEditable = false
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        return textView
    }()

    // MARK: - Rating view
    private lazy var ratingLabel = getLabel(text: "Rating")
    private lazy var ratingScrollView: UIScrollView = getScrollView()
    private lazy var ratingStackView: UIStackView = getStackView(arrangedSubviews: [])

    // MARK: - Actors view

    private lazy var actorLabel = getLabel(text: "Actors")
    private lazy var actorsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isEditing = false
        collection.isPagingEnabled = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    // MARK: - Posters view
    private lazy var posterLabel = getLabel(text: "Posters")
    private lazy var posterScrollView: UIScrollView = getScrollView()
    private lazy var posterStackView: UIStackView = getStackView(arrangedSubviews: [])

    // MARK: - Counters

    private lazy var actorsCounter = getCounter(count: "")
    private lazy var posterCounter = getCounter(count: "")

    // MARK: - Similar movies label

    private lazy var similarMoviesLabel: UILabel = getLabel(text: "Similar movies")
    private lazy var similarMoviesCounter: UILabel = getCounter(count: "")

    // MARK: - Similar movies view

    private lazy var similarMoviesScroll: UIScrollView = getScrollView()
    private lazy var similarMoviesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 15
        return stack
    }()

    // MARK: - viewDidLoad

    private lazy var loader = Loader.getLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        view.addSubview(loader)
        configureLoader()
        updatebutton.isEnabled = false

        if filmId > 0 {
            networkService.getFilmById(id: filmId) { film in
                self.film = film
            }
        } else {
            networkService.getRandomFilm { film in
                self.film = film
            }
        }

        URLCache.shared = URLCache(memoryCapacity: 500 * 1024 * 1024, diskCapacity: 500 * 1024 * 1024)

        actorsCollection.register(ActorCell.self, forCellWithReuseIdentifier: "Item")
        actorsCollection.dataSource = self
    }

    private func configureLoader() {
        loader.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        loader.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - setupScrollLayout

    private func setupScrollLayout() {
        let controllStackView = UIStackView(arrangedSubviews: [buttonLike, buttonBookMark, buttonShare])
        controllStackView.translatesAutoresizingMaskIntoConstraints = false
        controllStackView.axis = .horizontal
        controllStackView.distribution = .fillEqually

        view.addSubview(scrollView)
        view.addSubview(navigationBar)

        navigationBar.addSubview(navBarTitle)
        navigationBar.addSubview(backButton)
        navigationBar.addSubview(updatebutton)

        scrollView.addSubview(imageViewContainer)
        scrollView.addSubview(filmTitleLabel)
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
        scrollView.addSubview(posterCounter)
        scrollView.addSubview(posterScrollView)
        scrollView.addSubview(similarMoviesLabel)
        scrollView.addSubview(similarMoviesCounter)
        scrollView.addSubview(similarMoviesScroll)

        imageViewContainer.addSubview(imageView)

        setupScrollView(scrollView: ratingScrollView, stackView: ratingStackView)
        setupScrollView(scrollView: posterScrollView, stackView: posterStackView)
        setupScrollView(scrollView: similarMoviesScroll, stackView: similarMoviesStack)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),

            backButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 15),
            backButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),

            navBarTitle.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            navBarTitle.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),

            updatebutton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -15),
            updatebutton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
            updatebutton.heightAnchor.constraint(equalToConstant: 30),
            updatebutton.widthAnchor.constraint(equalToConstant: 30),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            imageViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -60),
            imageViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewContainer.widthAnchor.constraint(equalToConstant: view.bounds.width),
            imageViewContainer.heightAnchor.constraint(equalToConstant: 770),

            imageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 470),
            imageView.widthAnchor.constraint(equalToConstant: 300),

            filmTitleLabel.topAnchor.constraint(equalTo: imageViewContainer.bottomAnchor, constant: 15),
            filmTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            filmTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            filmTitleLabel.heightAnchor.constraint(equalToConstant: 60),

            filmsParamLabel.topAnchor.constraint(equalTo: filmTitleLabel.bottomAnchor, constant: 5),
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

            posterCounter.topAnchor.constraint(equalTo: actorsCollection.bottomAnchor, constant: 15),
            posterCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            posterCounter.heightAnchor.constraint(equalToConstant: 40),

            posterScrollView.topAnchor.constraint(equalTo: posterLabel.bottomAnchor, constant: 15),
            posterScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterScrollView.heightAnchor.constraint(equalToConstant: 150),

            similarMoviesLabel.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 15),
            similarMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            similarMoviesLabel.heightAnchor.constraint(equalToConstant: 40),

            similarMoviesCounter.topAnchor.constraint(equalTo: posterScrollView.bottomAnchor, constant: 15),
            similarMoviesCounter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            similarMoviesCounter.heightAnchor.constraint(equalToConstant: 40),

            similarMoviesScroll.topAnchor.constraint(equalTo: similarMoviesLabel.bottomAnchor, constant: 15),
            similarMoviesScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            similarMoviesScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            similarMoviesScroll.heightAnchor.constraint(equalToConstant: 310)

        ])
    }

    // MARK: - setupScrollView

    private func setupScrollView(scrollView: UIScrollView, stackView: UIStackView) {
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - getStackView

    private func getStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 15
        return stack
    }

    // MARK: - getScrollView

    private func getScrollView() -> UIScrollView {
        let rating = UIScrollView()
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.showsHorizontalScrollIndicator = false
        return rating
    }

    // MARK: - getLabel

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.labelFont
        return label
    }

    // MARK: - getCounter

    private func getCounter(count: String) -> UILabel {
        let counter = UILabel()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.text = count
        counter.textAlignment = .right
        counter.textColor = .counterColor
        counter.font = .labelFont
        return counter
    }

    // MARK: - getImage

    private func getMovie(id: Int, filmTitle: String, filmType: String, posterData: Data) -> UIButton {
        let container = UIButton(type: .custom)
        let image = UIImageView(image: UIImage(data: posterData))
        let textView = UITextView()
        container.titleLabel?.text = String(id)

        container.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(image)
        container.addSubview(textView)

        container.addTarget(self, action: #selector(openSimilarFilm(sender:)), for: .touchUpInside)

        image.contentMode = .scaleToFill

        textView.attributedText = getAttributedString(mainText: filmTitle, secondaryText: filmType)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 4

        NSLayoutConstraint.activate([
            container.widthAnchor .constraint(equalToConstant: 150),

            image.topAnchor.constraint(equalTo: container.topAnchor),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 225),

            textView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            textView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            textView.widthAnchor.constraint(equalToConstant: 150)
        ])

        return container
    }

    @objc func openSimilarFilm(sender: UIButton) {
        let destination = FilmController(networkService: NetworkService())
        destination.backButtonIsHidden = false
        destination.updateButtonIsHidden = true
        destination.filmId = Int(sender.titleLabel!.text!)!

        navigationController?.pushViewController(destination, animated: true)
    }
}

extension FilmController: UICollectionViewDataSource {

    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 100)
        layout.minimumLineSpacing = 20
        return layout
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? ActorCell
        guard let cell = cell else {
            let defaultCell = UICollectionViewCell()
            return defaultCell
        }

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
        collectionView.reloadData()
        return count
    }

}

extension FilmController {

    private func setFilmPoster() {
        guard let posterUrl = film?.poster?.url else { return }
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: posterUrl)!)) { data, _, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async { [self] in
                imageView.image = UIImage(data: data)
                imageViewContainer.image = UIImage(data: data)
            }
        }.resume()
    }

    private func setPosters(id: Int) {
        var postersUrl: [PostersURL]? {
            didSet {
                for elem in postersUrl! {
                    guard let posterUrl = elem.previewUrl ?? elem.url else { return }

                    URLSession.shared.dataTask(with: URLRequest(url: URL(string: posterUrl)!)) { [self] data, _, error in
                        guard let data = data, error == nil else { return }

                        DispatchQueue.main.async { [self] in
                            posterStackView.addArrangedSubview(getImage(data: data))
                        }
                    }.resume()
                }
                DispatchQueue.main.async {
                    self.posterCounter.text = String(postersUrl!.count)
                }
            }
        }
        networkService.getFilmPostersURL(id: id, completition: { data in
            if !data.isEmpty {
                postersUrl = data
            } else {
                DispatchQueue.main.async { [self] in
                    posterLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    posterCounter.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    posterScrollView.heightAnchor.constraint(equalToConstant: 0).isActive = true
                    scrollView.contentSize.height -= 200
                }
            }
        })
    }

    private func getImage(data: Data) -> UIImageView {
        let image = UIImageView(image: UIImage(data: data))
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false

        image.widthAnchor.constraint(equalToConstant: 300).isActive = true

        return image
    }

    private func setSimilarMovieImage() {
        guard let similarMovie = film?.similarMovies, !similarMovie.isEmpty else {
            similarMoviesLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            similarMoviesScroll.heightAnchor.constraint(equalToConstant: 0).isActive = true
            similarMoviesCounter.heightAnchor.constraint(equalToConstant: 0).isActive = true
            return
        }
        scrollView.contentSize.height += 350
        similarMoviesCounter.text = String(similarMovie.count)
        for elem in similarMovie {
            guard let posterURL = elem.poster?.previewUrl ?? elem.poster?.url! else { return }
            URLSession.shared.dataTask(with: URLRequest(url: URL(string: posterURL)!)) { [self] data, _, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async { [self] in
                    similarMoviesStack.addArrangedSubview(getMovie(id: elem.id!, filmTitle: elem.name!, filmType: elem.type!, posterData: data))
                }
            }.resume()
        }
    }
}
