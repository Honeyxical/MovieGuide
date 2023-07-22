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
            guard let homeUnselected = UIImage(systemName: TabBarUnselected.home.rawValue),
                  let homeSelected = UIImage(systemName: TabBarSelected.home.rawValue),
                  let randomUnselected = UIImage(systemName: TabBarUnselected.film.rawValue),
                  let randomSelected = UIImage(systemName: TabBarSelected.film.rawValue),
                  let searchUnselected = UIImage(systemName: TabBarUnselected.search.rawValue),
                  let searchSelected = UIImage(systemName: TabBarSelected.search.rawValue),
                  let profileUnselected = UIImage(systemName: TabBarUnselected.profile.rawValue),
                  let profileSelected = UIImage(systemName: TabBarSelected.profile.rawValue) else { return }
        
            viewControllers = [
                createNavigationController(for: HomeController(networkService: networkService, userService: userService, user: user),
                                           title: "Home", image: homeUnselected,
                                           selectedImage: homeSelected),
                createNavigationController(for: FilmController(networkService: networkService, userService: userService, user: user),
                                           title: "Random film",
                                           image: randomUnselected,
                                           selectedImage: randomSelected),
                createNavigationController(for: SearchController(networkService: networkService, userService: userService, user: user),
                                           title: "Search",
                                           image: searchUnselected,
                                           selectedImage: searchSelected),
                createNavigationController(for: ProfileController(userService: userService, user: user),
                                           title: "Profile",
                                           image: profileUnselected,
                                           selectedImage: profileSelected)
            ]
        }
    
    private func createNavigationController(for viewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navVC = viewController
        navVC.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return navVC
    }
    
    private func setupTabBarLayout() {
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
