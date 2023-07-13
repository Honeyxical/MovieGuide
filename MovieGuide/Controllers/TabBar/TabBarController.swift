import UIKit

enum TabBarUnselected: String {
    case home = "house.circle"
    case film = "film.circle"
    case search = "magnifyingglass.circle"
    case profile = "person.circle"
}

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
        
        setupTabBarLayout()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setupVCs() {
            viewControllers = [
                createNavController(for: HomeController(), title: "Home", image: UIImage(systemName: TabBarUnselected.home.rawValue)!),
                createNavController(for: FilmController(), title: "Random film", image: UIImage(systemName: TabBarUnselected.film.rawValue)!),
                createNavController(for: SearchController(), title: "Search", image: UIImage(systemName: TabBarUnselected.search.rawValue)!),
                createNavController(for: ProfileController(), title: "Profile", image: UIImage(systemName: TabBarUnselected.profile.rawValue)!)
            ]
        }
    
    fileprivate func createNavController(for viewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        return navController
    }
    
    fileprivate func setupTabBarLayout() {
        let island = UIView()
        
        island.translatesAutoresizingMaskIntoConstraints = false
        island.backgroundColor = .black
        island.layer.cornerRadius = 25
        
        island.addSubview(tabBar)
        view.addSubview(island)
        
        NSLayoutConstraint.activate([
            island.heightAnchor.constraint(equalToConstant: 65),
            island.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            island.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            island.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            island.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
    }
}
