//
//  SSOButtonView.swift
//  TestSDK
//
//  Created by kwanso-ios on 5/9/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import UIKit

public class SSOView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var btnLogin: UIButton!
    
    let ssoVC = SSOController()
    var vc : UIViewController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        //self.contentView.frame = frame
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func setViewController(viewController: UIViewController) {
        self.vc = viewController
    }
    
    
    func commonInit()
    {
//        let view = Bundle.main.loadNibNamed("SSOView", owner: self, options: nil)
        //let bundleIdentifier = "com.kwanso.bushnellProviderExtension"
        //let bundle = Bundle(identifier: bundleIdentifier)
        //let myView = bundle?.loadNibNamed("SSOView", owner: nil, options: nil)?.first as! UIView
        
        //Bundle.main.loadNibNamed("SSOView", owner: self, options: nil)

        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .green
//        button.setTitle("Test Button", for: .normal)
//        button.addTarget(self, action: #selector(SSOButtonView.buttonTapped), for: .touchUpInside)
        
    }
    
    @objc public func buttonTapped(sender: UIButton) {
        
        print("Button tapped")
    }

    @IBAction func actionOpenSSO(_ sender: Any) {
        print("Action Button tapped")
        
        //ssoVC.ssoAthuntication(target: sender as! UIViewController)
        
    }
}

