//
//  UITableViewCell_MyBoard.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 21..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_MyBoard : UITableViewCell
{
    @IBAction func DeleteAction(_ sender: Any) {
        let deleteAction = {
            // TODO 도형 : 게시물 삭제 기능
            //self.MyBoardViewController.RefreshUI()
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: MyBoardViewController!,
            title: "삭제",
            message: "삭제 하시겠습니까?",
            actionTitle_1: "네",
            actionFunc_1: deleteAction,
            actionTitle_2: "아니요")
    }
    @IBOutlet var Thumbnail: UIImageView!
    
    @IBOutlet var Name: UILabel!
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    @IBOutlet var Time: UILabel!

    @IBOutlet var BoardText: UILabel!
    
    var MyBoardViewController : UIViewController_MyBoardList? = nil
    var TampBoardData : BoardData? = nil
    
    public func SetMyBoardData(boardData : BoardData, view : UIViewController_MyBoardList)
    {
        MyBoardViewController = view
        TampBoardData = boardData
        if let myData = DataMgr.Instance.MyData
        {
            CommonUIFunc.Instance.SetThumbnail(imageView: Thumbnail, url: URL(string:myData.GetMainThumbnail())!, circle: true)
            CommonUIFunc.Instance.SetUserName(label: Name, userData: myData)
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:myData.Grade))
            
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: myData.BestItem))
        }
        
        BoardText.numberOfLines = 0
        BoardText.text = boardData.BoardText
        
        if CommonUIFunc.Instance.IsTodayTime(time:Date(timeIntervalSince1970: boardData.WriteTime))
        {
            Time.text = CommonUIFunc.Instance.ConvertTimeString(time: boardData.WriteTime, format:"HH:mm")
        }
        else
        {
            Time.text = CommonUIFunc.Instance.ConvertTimeString(time: boardData.WriteTime, format:"MM월 dd일")
        }
    }
}
