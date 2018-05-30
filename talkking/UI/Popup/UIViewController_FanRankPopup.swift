//
//  UIViewController_FanRankPopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 29..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_FanRankPopup : UIViewController_Popup
{
    @IBOutlet var RankIcon: UIImageView!
    @IBAction func Back(_ sender: Any) {
        self.DismissPopup()
    }
    
    var Rank : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RankIcon.image = UIImage.init(named: CommonUIFunc.Instance.GetFanRankBigImgName(rank: Rank))
    }
    
    public func SetFanRank(rank : Int)
    {
        Rank = rank
    }
}
