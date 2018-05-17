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
        
        CommonUIFunc.ShowLoading()
        CommonUIFunc.StartViewController = self
        let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil))
        var tempuuid = "2A81CBB50-66CB-40BD-AA4D-C5DD14C22EE7"
        tempuuid = "f8cf61f5d605463"
        FireBaseFunc.Instance.LoadUserIndex(uuid: tempuuid)
        
        let gif = UIImage(gifName: "logo_gif.gif")
        Logo.setGifImage(gif)
    }
}
