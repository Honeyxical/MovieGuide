import Foundation
import UIKit

@IBDesignable class PaddingLabel: UILabel{
    @IBInspectable var paddingTop: CGFloat = 0.0
    @IBInspectable var paddingLeft: CGFloat = 0.0
    @IBInspectable var paddingRight: CGFloat = 0.0
    @IBInspectable var paddingBottom: CGFloat = 0.0
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.paddingTop = padding.top
        self.paddingLeft = padding.left
        self.paddingBottom = padding.bottom
        self.paddingRight = padding.right
    }
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight)
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += self.paddingLeft + self.paddingRight
        contentSize.height += self.paddingTop + self.paddingBottom
        return contentSize
    }
}
