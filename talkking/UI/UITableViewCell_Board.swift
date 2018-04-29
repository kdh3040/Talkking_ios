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

    @IBAction func Report(_ sender: Any) {
    }
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Board: UILabel!
    @IBOutlet var Time: UILabel!
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    public func SetBoardCell(boardData:BoardData)
    {
        if let cellUserData = DataMgr.Instance.GetCachingUserDataList(index: boardData.UserIndex)
        {
            let url = URL(string: cellUserData.GetMainThumbnail())!
            Thumbnail.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
            
            Thumbnail.layer.cornerRadius = Thumbnail.frame.size.width / 2
            Thumbnail.clipsToBounds = true
            
            Name.text = cellUserData.Name
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:cellUserData.Grade))
            
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: cellUserData.BestItem))
            
            Board.text = boardData.BoardText
            let writeTime = Date(timeIntervalSince1970: boardData.WriteTime)
            
            if CommonUIFunc.Instance.IsTodayTime(time:writeTime)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                Time.text = dateFormatter.string(from: writeTime)
            }
            else
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM월 dd일"
                Time.text = dateFormatter.string(from: writeTime)
            }
        }
    }
}
