//
//  UIViewController_RankPopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 16..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_RankPopup : UIViewController_Popup
{
    @IBAction func OkAction(_ sender: Any) {
        self.DismissPopup()
    }
    @IBOutlet var AccumulateCoin: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myData = DataMgr.Instance.MyData
        {
            AccumulateCoin.text = CommonUIFunc.Instance.ConvertNumberFormat(count: myData.Point)
        }
    }
}
