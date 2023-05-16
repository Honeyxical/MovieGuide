import UIKit

class FavoriteController: UIViewController {
    
    var filmsId: [Int] = []
    
    private var films: [FilmShortInfo?] = []{
        didSet{
            print(films)
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
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        getFilms()
//        setupLayout()
        
    }
    
//    private func setupLayout() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
    
    private func setupLoaderLayout() {
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getFilms() {
        for id in filmsId {
            NetworkService.network.getFilmById(id: id) { [self] data in
                films.append(FilmShortInfo(id: data.id, name: data.name, alternativeName: data.alternativeName, description: data.description, shortDescription: data.shortDescription))
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
}
