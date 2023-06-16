import UIKit

enum tabBarUnselected: String {
    case home = "house.circle"
    case film = "film.circle"
    case search = "magnifyingglass.circle"
    case profile = "person.circle"
}

enum tabBarSelected: String {
    case home = "house.circle.fill"
    case film = "film.circle.fill"
    case search = "magnifyingglass.circle.fill"
    case profile = "person.circle.fill"
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
                createNavController(for: HomeController(), title: "Home", image: UIImage(systemName: tabBarUnselected.home.rawValue)!, selectedImage: UIImage(systemName: tabBarSelected.home.rawValue)!),
                createNavController(for: FilmController(), title: "Random film", image: UIImage(systemName: tabBarUnselected.film.rawValue)!, selectedImage: UIImage(systemName: tabBarSelected.film.rawValue)!),
                createNavController(for: SearchController(), title: "Search", image: UIImage(systemName: tabBarUnselected.search.rawValue)!, selectedImage: UIImage(systemName: tabBarSelected.search.rawValue)!),
                createNavController(for: ProfileController(), title: "Profile", image: UIImage(systemName: tabBarUnselected.profile.rawValue)!, selectedImage: UIImage(systemName: tabBarSelected.profile.rawValue)!),
            ]
        }
    
    fileprivate func createNavController(for viewController: UIViewController,
                                         title: String,
                                         image: UIImage, selectedImage: UIImage) -> UIViewController {
        let vc = viewController
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return vc
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
