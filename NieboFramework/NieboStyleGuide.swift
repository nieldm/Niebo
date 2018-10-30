import UIKit
// Color palette

extension UIColor {
    
    @nonobjc class var paleLavender: UIColor {
        return UIColor(red: 235.0 / 255.0, green: 233.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var dusk36: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 76.0 / 255.0, blue: 99.0 / 255.0, alpha: 0.36)
    }
    
    @nonobjc class var dusk: UIColor {
        return UIColor(red: 84.0 / 255.0, green: 76.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var wisteria: UIColor {
        return UIColor(red: 166.0 / 255.0, green: 163.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightGrayBG: UIColor {
        return UIColor(red: 246 / 255.0, green: 245.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleyGrey: UIColor {
        return UIColor(red: 137.0 / 255.0, green: 130.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var turquoiseBlue: UIColor {
        return UIColor(red: 0.0, green: 178.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
}

// Text styles

extension UIFont {
    
    class var secondaryBodyDisabledGray14PtRegular: UIFont {
        return UIFont.systemFont(ofSize: 14.0, weight: .regular)
    }
    
    class var footnote13PtGrey: UIFont {
        return UIFont.systemFont(ofSize: 13.0, weight: .regular)
    }
    
    class var footnote13PtBlack: UIFont {
        return UIFont.systemFont(ofSize: 13.0, weight: .regular)
    }
    
}
