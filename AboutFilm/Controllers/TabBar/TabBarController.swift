import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    func setupVCs() {
            viewControllers = [
                createNavController(for: HomeController(), title: "Home", image: UIImage(systemName: "house")!),
                createNavController(for: FilmController(), title: "Random film", image: UIImage(systemName: "film.circle")!),
                createNavController(for: SearchController(), title: "Search", image: UIImage(systemName: "magnifyingglass")!),
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
}
