//
//  UITableViewCell_Board.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_Board : UITableViewCell
{
    
    @IBOutlet var Time: UILabel!
    @IBAction func Notice(_ sender: Any) {
    }
    @IBOutlet var Board: UILabel!
    @IBOutlet var Rank: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Thumbnail: UIImageView!
    public func SetBoardCell(userData:UserData)
    {

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 실제로 선택 하였을때 호출 되는 함수를 찾아야 한다.
        print("세팅 및 선택")
    }
}
