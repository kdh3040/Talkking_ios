//
//  UITableViewCell_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UITableViewCell_Favor : UITableViewCell
{
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    
    public func SetFavorCell(userData:UserData?)
    {
        if let cellUserData = userData
        {
            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/talkking-25dd8.appspot.com/o/images%2F50%2FThumbNail?alt=media&token=6d5ff51a-8d46-405b-8a23-8d1726b7b9e3")!
            Thumbnail.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
            
            Thumbnail.layer.cornerRadius = Thumbnail.frame.size.width / 2
            Thumbnail.clipsToBounds = true
            
            Name.text = cellUserData.Name
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:1))

            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: 1))
            
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // 실제로 선택 하였을때 호출 되는 함수를 찾아야 한다.
        print("세팅 및 선택")
    }
}
