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
        if CommonFunc.Instance.IsBoardWriteEnable(showPopup: true, view: self) == true
        {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "BOARD_WRITE_POPUP") as! UIViewController_BoardWritePopup
            page.SetBoardView(view:self)
            page.ShowPopup(viewController: self)
        }
    }
    @IBAction func MyBoardListAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MY_BOARD_LIST") as! UIViewController_MyBoardList
        page.SetBoardView(view:self)
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
        
        RefreshUI()
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
        CommonUIFunc.Instance.MoveUserPage(index:DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex, view : self)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if SVProgressHUD.isVisible() == true
        {
            return
        }

        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) - 10) {
            // 게시판 로딩
            FireBaseFunc.Instance.LoadBoardDataList(top:false, complete:RefreshUI)
            print("스크롤 하단")
        }
        
        if (floor(scrollView.contentOffset.y) <= 0){
            // 게시판 로딩
            FireBaseFunc.Instance.LoadBoardDataList(top:true, complete:RefreshUI)
            print("스크롤 상단")
        }
    }
}

extension UIViewController_Board
{
    public func RefreshUI()
    {
        BoardLoadCnt = 0
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

    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : Int = DataMgr.Instance.CachingBoardDataList[indexPath.row].UserIndex
        
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: index)!
    }
}
