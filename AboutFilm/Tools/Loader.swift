import Foundation
import UIKit

struct Loader{
    func getLoader(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: width / 2, y: height / 2)
        activityIndicator.startAnimating()
        view.addSubview(getBlur(for: view, style: .extraLight))
        view.addSubview(activityIndicator)
        return view
    }
    
    func getBlur(for object: AnyObject, style: UIBlurEffect.Style) -> UIVisualEffectView{
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blur.frame = object.bounds
        return blur
    }
    
    func palceholderImage()-> UIImage{
        return UIImage(named: "PlaceholderImage")!
    }
}
