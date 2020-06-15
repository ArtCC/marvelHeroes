//
//  AppStyler.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class AppStyler: NSObject {
    
    /// Default red app color.
    ///
    /// - Returns: valid UIColor.
    static func defaultRedAppColor() -> UIColor {
        return UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    
    /// Default dark app color.
    /// - Returns: valid UIColor.
    static func darkAppColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    /// Default custmo app semibold.
    static func customAppSemiBoldFont() -> String {
        return "Montserrat-SemiBold"
    }
    
    /// Style navigation bar.
    /// - Parameter navigationController: navigation controller to apply style.
    /// - Parameter transparent: setup navigation transparent.
    /// - Parameter useDark: use dark mode in navigation.
    static func styleNavigationBar(navigationController: UINavigationController, transparent: Bool = false) {
        if transparent {
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.isTranslucent = true
            navigationController.view.backgroundColor = .clear
            navigationController.navigationBar.tintColor = UIColor.white
        } else {
            navigationController.navigationBar.tintColor = UIColor.white
        }
        if let font = UIFont(name: AppStyler.customAppSemiBoldFont(), size: CGFloat(16.0)) {
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,
                                                                      NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
    /// Generate image from layer to apply as view.
    /// - Parameter layer: reference layer.
    /// - Returns: image ready to use from layer.
    static func imageFrom(layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
    /// Generate image form color.
    /// - Parameter color: input color.
    static func imageFrom(color: UIColor) -> UIImage? {
        let size = CGSize(width: 100.0, height: 100.0)
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
