//
//  UIViewControllerExtensions.swift
//  EngineeringAITest
//
//  Created by PCQ188 on 26/02/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController {
    func showProgressHud() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    func hideProgressHud() {
        SVProgressHUD.dismiss()
    }
}
