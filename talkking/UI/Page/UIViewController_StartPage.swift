//
//  UIViewController_StartPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 17..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import SwiftyGif

class UIViewController_StartPage : UIViewController
{
    @IBOutlet var Logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CommonUIFunc.StartViewController = self
        let gif = UIImage(gifName: "logo_gif.gif")
        Logo.setGifImage(gif)
    }
}
