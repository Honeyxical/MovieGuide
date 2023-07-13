import UIKit

enum TabBarUnselected: String {
    case home = "house.circle"
    case film = "film.circle"
    case search = "magnifyingglass.circle"
    case profile = "person.circle"
}

enum TabBarSelected: String {
    case home = "house.circle.fill"
    case film = "film.circle.fill"
    case search = "magnifyingglass.circle.fill"
    case profile = "person.circle.fill"
}

class TabBarController: UITabBarController {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
                createNavigationController(for: HomeController(networkService: networkService),
                                           title: "Home", image: UIImage(systemName: TabBarUnselected.home.rawValue)!,
                                           selectedImage: UIImage(systemName: TabBarSelected.home.rawValue)!),
                createNavigationController(for: FilmController(networkService: networkService),
                                           title: "Random film",
                                           image: UIImage(systemName: TabBarUnselected.film.rawValue)!,
                                           selectedImage: UIImage(systemName: TabBarSelected.film.rawValue)!),
                createNavigationController(for: SearchController(networkService: networkService),
                                           title: "Search",
                                           image: UIImage(systemName: TabBarUnselected.search.rawValue)!,
                                           selectedImage: UIImage(systemName: TabBarSelected.search.rawValue)!),
                createNavigationController(for: ProfileController(),
                                           title: "Profile",
                                           image: UIImage(systemName: TabBarUnselected.profile.rawValue)!,
                                           selectedImage: UIImage(systemName: TabBarSelected.profile.rawValue)!)
            ]
        }
    
    fileprivate func createNavigationController(for viewController: UIViewController,
                                         title: String,
                                         image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navVC = viewController
        navVC.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return navVC
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
