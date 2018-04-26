//
//  UITableViewCell_Fan.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 26..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_Fan : UITableViewCell
{
    @IBOutlet var HeartCount: UILabel!
    @IBOutlet var Name: UILabel!
    @IBOutlet var NewIcon: UIImageView!
    @IBOutlet var RankLabel: UILabel!
    @IBOutlet var Rank: UIImageView!
    @IBOutlet var Thumbnail: UIImageView!
    public func SetFanCell(userData:UserData)
    {

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 실제로 선택 하였을때 호출 되는 함수를 찾아야 한다.
        print("세팅 및 선택")
    }
}
