//
//  UITableViewCell_Notice.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 11..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_Notice : UITableViewCell
{
    @IBOutlet var Title: UILabel!
    @IBOutlet var Time: UILabel!
 
    public func SetNoticeData()
    {
        Title.text = "공지입니다."
        Time.text = "10-23-44"
    }
}
