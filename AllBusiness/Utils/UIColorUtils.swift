//
//  UIColor+Extension.swift
//
//  Created by apple on 2/7/17.
//

import Foundation
import UIKit

extension UIColor {
    
    static var defaultColorString = "#000000"
    
    static func getColorScheme(_ key: String) -> String {
        guard
            let path = Bundle.main.path(forResource: "UIColorScheme", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String:String] else {
            return defaultColorString
        }
        return dict[key] ?? defaultColorString
    }
    
    @nonobjc static var navigation = UIColor.from(hex: getColorScheme("navigation"))
    @nonobjc static var background = UIColor.from(hex: getColorScheme("background"))
    @nonobjc static var text = UIColor.from(hex: getColorScheme("text"))
    @nonobjc static var activityIndicator = UIColor.from(hex: getColorScheme("activityIndicator"))
    
    public static func from(hex: String, alpha: CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hex))
        let red    = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green  = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue   = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha  = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    public static func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersIn: "#") as CharacterSet
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
