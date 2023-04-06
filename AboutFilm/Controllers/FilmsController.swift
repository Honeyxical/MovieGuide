import UIKit

class FilmsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let networkService = NetworkService()
    
    var films: [Docs] = []{
        didSet{
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
//        networkService.getFilms { docs in
//            self.films = docs
//        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FilmsCell", bundle: nil), forCellReuseIdentifier: "FilmsCell")
        tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        networkService.getFilms { docs in
            self.films = docs
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell") as! FilmsCell
        if films.isEmpty {
            return cell
        }
        let film = films[indexPath.row]
        cell.configure(image: film.poster!.posterData, title: film.name!, shortDescription: film.shortDescription!)
        
        return cell
    }
    

}
