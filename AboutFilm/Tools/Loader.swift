import Foundation
import UIKit

struct Loader{
    func getLoader(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: width / 2, y: height / 2)
        view.addSubview(activityIndicator)
        view.backgroundColor = .gray
        activityIndicator.startAnimating()
        return view
    }
}
