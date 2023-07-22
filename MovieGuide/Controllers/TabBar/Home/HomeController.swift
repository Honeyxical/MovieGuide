import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let networkService: NetworkServiceProtocol
    let userService: UserServiceProtocol
    let user: User

    init(networkService: NetworkServiceProtocol, userService: UserServiceProtocol, user: User) {
        self.networkService = networkService
        self.userService = userService
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var films: [FilmShortInfo?] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FilmsCell", bundle: nil), forCellReuseIdentifier: "FilmsCell")
        return tableView
    }()

    private lazy var loader = Loader.getLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(loader)
        setupLayout()
        configureLoader()

        networkService.getFilmList { docs in
            self.films = docs
            self.updateTableView()
        }

        tableView.delegate = self
        tableView.dataSource = self
    }

    func updateTableView(){
        tableView.reloadData()
        loader.removeFromSuperview()
    }

    private func configureLoader() {
        loader.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        loader.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupLayout() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell") as? FilmsCell
        guard let cell = cell else {
            let defaultCell = UITableViewCell()
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
