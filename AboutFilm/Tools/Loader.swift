import Foundation
import UIKit

struct Loader{
    static let loader = Loader()
    
    func getLoader(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: width / 2, y: height / 2)
        activityIndicator.startAnimating()
        view.addSubview(getBlur(for: view, style: .extraLight))
        view.addSubview(activityIndicator)
        return view
    }
    
    static func getLoader() -> UIView{
        let loader = UIView()
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        loader.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: loader.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loader.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
        return loader
    }
    
    func getBlur(for object: AnyObject, style: UIBlurEffect.Style) -> UIVisualEffectView{
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blur.translatesAutoresizingMaskIntoConstraints = false
        object.addSubview(blur)
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: object.topAnchor),
            blur.leadingAnchor.constraint(equalTo: object.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: object.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: object.bottomAnchor)
        ])
        
        return blur
    }
    
    
    
    func palceholderImage()-> UIImage{
        return UIImage(named: "PlaceholderImage")!
    }
}
