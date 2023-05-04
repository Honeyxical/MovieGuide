import UIKit

class SearchResultController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var loader: UIView? = nil
    var navbarTitle = "Search: "
    var films: [SearchFilmInfo?] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loader?.removeFromSuperview()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleNavBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = Loader().getLoader(x: 0, y: 95, width: tableView.bounds.width, height: tableView.bounds.height)
        view.addSubview(loader!)
        
        titleNavBar.title = navbarTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }
    
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
        
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmDescriptionController") as! FilmDescriptionController
        
        destination.filmId = filmId
        destination.updateButtonIsHidden = true
        destination.backButtonIsHidden = false
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
