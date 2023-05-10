import UIKit

class FilmsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var films: [FilmShortInfo?] = []{
        didSet{
            DispatchQueue.main.async { [self] in
                self.tableView.reloadData()
                self.loader.removeFromSuperview()
                setupLayout()
            }
        }
    }
    
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
        view.addSubview(loader)
        configureLoader()
        
        NetworkService.network.getFilmList { docs in
            self.films = docs
        }
        
        URLCache.shared = URLCache(memoryCapacity: 500 * 1024 * 1024, diskCapacity: 500 * 1024 * 1024)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureLoader() {
        loader.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        loader.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
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
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell") as! FilmsCell
        
        if films.isEmpty {
            return cell
        }
        
        guard let film = films[indexPath.row] else {
            return cell
        }
        
        cell.film = film
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let film = films[indexPath.row], let filmId = film.id else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let destination = FilmDescriptionController()
        
        destination.filmId = filmId
        destination.backButtonIsHidden = false
        destination.updateButtonIsHidden = true
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
