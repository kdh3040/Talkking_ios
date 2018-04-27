//
//  UITableViewCell_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_Favor : UITableViewCell
{
    @IBOutlet var Rank: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Thumbnail: UIImageView!
    
    public func SetFavorCell(userData:UserData?)
    {
        // 데이터를 추가 해야 한다.
        Name.text = userData?.Name
        //Rank.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade: userData.Grade))
        //Thumbnail = UIImage.
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 실제로 선택 하였을때 호출 되는 함수를 찾아야 한다.
        print("세팅 및 선택")
    }
}
