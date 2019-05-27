//
//  UIViewController+Extension.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/16/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func setGradientBackground(view: AnyObject) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.bushnellGrayColor().cgColor,  UIColor.silverColor().cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public func setViewBorder(_ yourView: AnyObject, withWidth borderWidth: CGFloat, andColor borderColor: UIColor, cornerRadius radius: CGFloat) {
        
        yourView.layer.cornerRadius = radius
        yourView.layer.borderColor = borderColor.cgColor
        yourView.layer.borderWidth = borderWidth
    }
    
    func showAlertWithMessageAndTarget(_ title: String?, message: String?, btnTitle: String?, target: UIViewController) {
        
        let alertController = UIAlertController(title: title!, message: message!, preferredStyle: .alert)
        let accept = UIAlertAction(title: btnTitle, style: .default, handler: nil)
        alertController.addAction(accept)
        target.present(alertController, animated: true, completion:nil)
    }
}
