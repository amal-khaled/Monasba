//
//  AddingCustomFont.swift
//  Sla
//
//  Created by Amal Elgalant on 4/21/20.
//  Copyright © 2020 Amal Elgalant. All rights reserved.
//

import Foundation
import UIKit

struct AppFontName {
    static let regular = "BalooBhaijaan2-Regular"
    static let SemiBold = "BalooBhaijaan2-Bold"
    static let medium = "BalooBhaijaan2-Medium"
    static let Bold = "BalooBhaijaan2-ExtraBold"

}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    static var isOverrided: Bool = false

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.SemiBold, size: size)!
    }

    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.SemiBold, size: size)!
    }
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.Bold, size: size)!
    }

    @objc class func mediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
            
        case "CTFontEmphasizedUsage", "CTFontBoldUsage", "CTFontSemiboldUsage":
            fontName = AppFontName.SemiBold
        case "CTFontHeavyUsage", "CTFontBlackUsage":
            fontName = AppFontName.Bold
        case "CTFontMediumUsage":
            fontName = AppFontName.medium
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }

        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

//        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
//            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(appBoldFontWith(ofSize:))) {
//            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
//        }
        if let semiBoldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(mySemiBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(semiBoldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let mediumSystemFontMethod = class_getClassMethod(self, #selector(mediumSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(mediumSystemFont(ofSize:))) {
            method_exchangeImplementations(mediumSystemFontMethod, myItalicSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
