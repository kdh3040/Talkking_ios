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
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : true)
        
        if let cellUserData = DataMgr.Instance.GetCachingUserDataList(index: boardData.UserIndex)
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : true)
            
            Name.text = cellUserData.Name
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:cellUserData.Grade))
            
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: cellUserData.BestItem))
        }
        
        Board.text = boardData.BoardText
        Time.text = CommonUIFunc.Instance.ConvertTimeString(time: boardData.WriteTime)
    }
}
