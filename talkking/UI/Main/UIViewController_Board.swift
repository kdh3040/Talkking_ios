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

class UIViewController_Board : UIViewController
{
    @IBAction func WriteAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "BOARD_WRITE_POPUP") as! UIViewController_BoardWritePopup
        page.ShowPopup(viewController: self)
    }
    @IBAction func MyBoardListAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MY_BOARD_LIST") as! UIViewController_MyBoardList
        self.present(page, animated: true)
    }
    
    @IBOutlet var BoardTableView: UITableView!
    
    var BoardCnt =  0
    var BoardLoadCnt =  0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BoardTableView.delegate = self
        BoardTableView.dataSource = self
        BoardTableView.rowHeight = UITableViewAutomaticDimension
        BoardTableView.estimatedRowHeight = 70
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
        if BoardLoadCnt == 0
        {
            BoardCnt = DataMgr.Instance.CachingBoardDataList.count
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController_Board : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BoardCnt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Board
        
        cell.SetBoardCell(boardData: DataMgr.Instance.CachingBoardDataList[indexPath.row], view : self)
        return cell
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
            CommonUIFunc.ShowLoading()
            FireBaseFunc.Instance.LoadUserData(index: String(DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex), complete: CallBackFunc_LoadUserData)
        }
    }
    
    /*
     07. scrollViewDidScroll
     scroll이 일정 offset에 다다르면, 데이터를 추가로 요청할 수 있다.
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
     if contentSize.offset.y < 100 {
     data 추가 요청
     }
     }
 */
}

extension UIViewController_Board
{
    public func RefreshUI()
    {
        BoardCnt = DataMgr.Instance.CachingBoardDataList.count
        BoardTableView.reloadData()
    }
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == BoardLoadCnt
        {
            CommonUIFunc.DismissLoading()
            RefreshUI()
            FireBaseFunc.Instance.CallBackCount = 0
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
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : Int = DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex
        
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: index)!
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData?
    {
        let userIndex = DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex
        
        return DataMgr.Instance.GetCachingUserDataList(index: userIndex)
    }
}
