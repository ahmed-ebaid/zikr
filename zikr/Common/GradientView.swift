import UIKit

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradientLayer()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
    }
    
    func configureGradientLayer() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor.white.cgColor, UIColor(red: 93/255, green: 188/255, blue: 210/255, alpha: 0).cgColor]
    }
}
