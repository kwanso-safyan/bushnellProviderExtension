//
//  MBProgressHUD+Helper.swift
//  bushnell-sso
//
//  Created by kwanso-ios on 4/22/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    public class func showHUDAddedGlobal() -> MBProgressHUD?
    {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.hide(for: window!, animated: false)
            let hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.animationType = MBProgressHUDAnimation.fade

            return hud
        }
        return nil
    }
    
    public class func dismissGlobalHUD()
    {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.hide(for: window!, animated: true)
        }
    }
}
