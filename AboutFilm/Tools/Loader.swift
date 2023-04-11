import Foundation
import UIKit

struct Loader{
    func getLoader(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView{
        let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        view.backgroundColor = .gray
        return view
    }
}
