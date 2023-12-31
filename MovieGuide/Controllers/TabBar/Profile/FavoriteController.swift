import UIKit

class FavoriteController: UIViewController {
    let networkService: NetworkService
    let userService: UserServiceProtocol
    let user: User

    init(networkService: NetworkService, userService: UserServiceProtocol, user: User) {
        self.networkService = networkService
        self.userService = userService
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var films: [FilmShortInfo?] = []

    private let navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let backButton = UIButton(type: .system)
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(nil, action: #selector(backButtonHandler), for: .touchUpInside)

        let title = UILabel()
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Favotites"
        title.textColor = .black

        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true

        title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()

    @objc private func backButtonHandler() {
        navigationController?.popViewController(animated: true)
    }

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "FilmsCell", bundle: nil), forCellReuseIdentifier: "FilmsCell")
        table.separatorStyle = .none
        return table
    }()

    private let loader: UIView = {
        let loader = Loader.getLoader()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLoaderLayout()
        getFilms()
    }

    private func setupLoaderLayout() {
        view.addSubview(loader)

        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),

            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func getFilms() {
        films = []
        if userService.getFavouritesFilms().isEmpty {
            displayPlug()
            return
        }

        for id in userService.getFavouritesFilms() {
            networkService.getFilmById(id: id) { [self] data in
                films.append(FilmShortInfo(id: data.id,
                                           name: data.name,
                                           alternativeName: data.alternativeName,
                                           description: data.description,
                                           shortDescription: data.shortDescription,
                                           poster: data.poster))
                self.tableView.reloadData()
            }
        }
    }

    private func displayPlug() {
        tableView.removeFromSuperview()
        loader.removeFromSuperview()

        let plug = UILabel()
        plug.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plug)
        plug.text = "No favorite movies"
        plug.font = .systemFont(ofSize: 40)

        plug.textColor = .lightGray

        plug.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plug.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
}

extension FavoriteController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell") as? FilmsCell
        guard let cell = cell else {
            let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
            return defaultCell
        }

        if films.isEmpty {
            return cell
        }

        guard let film = films[indexPath.row] else {
            return cell
        }

        cell.film = film
        cell.setData()

        loader.removeFromSuperview()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let film = films[indexPath.row], let filmId = film.id else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let destination = FilmController(networkService: NetworkService(), userService: userService, user: user)

        destination.filmId = filmId
        destination.backButtonIsHidden = false
        destination.updateButtonIsHidden = true

        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
