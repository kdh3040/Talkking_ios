//
//  UIViewController_Popup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_Popup : UIViewController
{
    public var parentView : UIViewController? = nil
    
    public func SetParentView(viewController: UIViewController)
    {
        parentView = viewController
    }
    
    public func ShowPopup(viewController: UIViewController)
    {
        self.SetParentView(viewController: viewController)
        viewController.addChildViewController(self)
        viewController.view.addSubview(self.view)
        self.didMove(toParentViewController: viewController)
    }
    
    public func DismissPopup()
    {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
