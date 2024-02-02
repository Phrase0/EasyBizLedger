//
//  UIColor+Extension.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/1/2.
//

import UIKit

extension UIColor {
    
    static let baseBackgroundColor = UIColor.setColor(lightColor: .white, darkColor: .black)
    
    static func setColor(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .light ? lightColor : darkColor
            }
        } else {
            return lightColor
        }
    }
}
