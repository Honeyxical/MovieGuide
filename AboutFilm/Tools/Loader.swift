import Foundation
import UIKit

struct Loader{
    
    static func getLoader() -> UIView{
        let loader = UIView()
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.backgroundColor = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        loader.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: loader.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loader.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
        return loader
    }
    
    static func getBlur(for object: AnyObject, style: UIBlurEffect.Style) -> UIVisualEffectView{
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
}
