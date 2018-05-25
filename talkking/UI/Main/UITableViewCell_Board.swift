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
    @IBOutlet var ReportButton: UIButton!
    @IBAction func Report(_ sender: Any) {
        let reportAction = {
            if let data = self.TampBoardData
            {
                DataMgr.Instance.RemoveBoardData(index: data.BoardIndex)
                
                if data.ReportList.count >= CommonData.REPORT_BOARD_DELETE - 1
                {
                    FireBaseFunc.Instance.RemoveBoardData(boardIdx: data.BoardIndex)
                }
                else
                {
                    FireBaseFunc.Instance.ReportBoardData(boardIdx: data.BoardIndex)
                }
                self.BoardViewController!.RefreshUI()
            }
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: BoardViewController!,
            title: "신고",
            message: "신고 하시겠습니까?",
            actionTitle_1: "네",
            actionFunc_1: reportAction,
            actionTitle_2: "아니요")
    }
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Board: UILabel!
    @IBOutlet var Time: UILabel!
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var BestItem: UIImageView!
    
    var BoardViewController : UIViewController_Board? = nil
    var TampBoardData : BoardData? = nil
    
    public func SetBoardCell(boardData:BoardData, view : UIViewController_Board)
    {
        TampBoardData = boardData
        BoardViewController = view
        
        if TampBoardData?.UserIndex == DataMgr.Instance.MyData!.Index
        {
            ReportButton.isHidden = true
        }
        else
        {
            ReportButton.isHidden = false
        }
        
        CommonUIFunc.Instance.SetDefaultThumbnail(imageView : Thumbnail, circle : true)
        
        if let cellUserData = DataMgr.Instance.GetCachingSimpleUserDataList(index: boardData.UserIndex)
        {
            CommonUIFunc.Instance.SetThumbnail(imageView :  Thumbnail, url : URL(string: cellUserData.GetMainThumbnail())!, circle : true)
            
            CommonUIFunc.Instance.SetUserName(label: Name, userData: cellUserData)
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:cellUserData.Grade))
            
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: cellUserData.BestItem))
        }

        Board.numberOfLines = 0
        Board.text = boardData.BoardText
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
