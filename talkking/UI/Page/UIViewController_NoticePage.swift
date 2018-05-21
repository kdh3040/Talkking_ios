//
//  UIViewController_NoticePage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 11..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_NoticePage : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var Notice: UITextView!
    
    var NotiData : NotificationData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let data = NotiData
        {
             Notice.text = data.Body
        }
    }
    
    public func SetNotice(notiData : NotificationData)
    {
        NotiData = notiData
    }
}
