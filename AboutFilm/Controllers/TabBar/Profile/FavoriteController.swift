import UIKit

class FavoriteController: UIViewController {
    
    private var films: [FilmShortInfo?] = []{
        didSet{
            DispatchQueue.main.async { [self] in
                loader.removeFromSuperview()
                tableView.reloadData()
            }
        }
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
        getFilms()
    }
    
    
    private func setupLoaderLayout() {
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getFilms() {
        guard let user = Auth.auth.getCurrentUser() else { return }
        for id in user.getFavouritesFilms() {
            NetworkService.network.getFilmById(id: id) { [self] data in
                films.append(FilmShortInfo(id: data.id, name: data.name, alternativeName: data.alternativeName, description: data.description,shortDescription: data.shortDescription, poster: data.poster))
            }
        }
    }
}


extension FavoriteController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
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
        let destination = FilmController()
        
        destination.filmId = filmId
        destination.backButtonIsHidden = false
        destination.updateButtonIsHidden = true
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
