//
//  UIViewController_Board.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIViewController_Board : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBAction func WriteAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "BOARD_WRITE_POPUP") as! UIViewController_BoardWritePopup
        page.ShowPopup(viewController: self)
    }
    
    @IBOutlet var BoardTableView: UITableView!
    
    var BoardCnt =  0
    var BoardLoadCnt =  0
    
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == BoardLoadCnt
        {
            CommonUIFunc.DismissLoading()
            BoardCnt = DataMgr.Instance.CachingBoardDataList.count
            BoardTableView.reloadData()
        }
    }
    
    private func CallBackFunc_LoadUserData(index : Int)
    {
        CommonUIFunc.DismissLoading()
        let userData : UserData = DataMgr.Instance.GetCachingUserDataList(index: index)!
        let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.SetUserData(userData: userData)
        self.present(page, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BoardTableView.delegate = self
        BoardTableView.dataSource = self
        BoardTableView.rowHeight = 70
        BoardTableView.separatorStyle = .none
        
        for i in 0..<DataMgr.Instance.CachingBoardDataList.count
        {
            if (DataMgr.Instance.GetCachingSimpleUserDataList(index: DataMgr.Instance.CachingBoardDataList[i].UserIndex) == nil)
            {
                CommonUIFunc.ShowLoading()
                FireBaseFunc.Instance.LoadSimpleUserData(index: String(DataMgr.Instance.CachingBoardDataList[i].UserIndex), complete: CallBackFunc_LoadSimpleUserData)
                BoardLoadCnt += CommonData.LOAD_DATA_SET
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return (DataMgr.Instance.CachingBoardDataList.count)
        return BoardCnt
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Board
        
        cell.SetBoardCell(boardData: DataMgr.Instance.CachingBoardDataList[indexPath.row])
        return cell
    }
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : Int = DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex
        
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: index)!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let userData = GetSelectUserData(indexPath:indexPath)
        {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
            page.SetUserData(userData: userData)
            self.present(page, animated: true)
        }
        else
        {
            // 로딩하세요
            CommonUIFunc.ShowLoading()
            FireBaseFunc.Instance.LoadUserData(index: String(DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex), complete: CallBackFunc_LoadUserData)
        }
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData?
    {
        let userIndex = DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex
        
        return DataMgr.Instance.GetCachingUserDataList(index: userIndex)
    }
}
