
import UIKit
@IBDesignable
class StartButtonClass: UIButton {
    
    @IBInspectable var isReset : Bool = false
    @IBInspectable var isStop : Bool = false
    @IBInspectable var isTabata : Bool = false
    
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.whiteColor().setFill()
        path.fill()
    }
    
    
}

