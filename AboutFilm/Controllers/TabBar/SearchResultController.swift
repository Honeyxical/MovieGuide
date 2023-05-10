import UIKit

class SearchResultController: UIViewController {
    var navbarTitle = "Search: "
    var films: [SearchFilmInfo?] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loader.removeFromSuperview()
                self.setupLayout()
            }
        }
    }
    
    private lazy var navigationBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: navbarTitle)
        let backItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), landscapeImagePhone: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(back))
        
        navBar.isTranslucent = false
        
        navItem.leftBarButtonItem = backItem
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var loader = Loader.getLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(loader)
        configureLoader()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }
    
    private func configureLoader() {
        loader.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        loader.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension SearchResultController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        if films.isEmpty{
            return cell
        }
        
        guard let film =  films[indexPath.row] else {
            return cell
        }
        
        cell.film = film
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let film = films[indexPath.row] , let filmId = film.id else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        let destination = FilmDescriptionController()
        
        destination.filmId = filmId
        destination.updateButtonIsHidden = true
        destination.backButtonIsHidden = false
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
