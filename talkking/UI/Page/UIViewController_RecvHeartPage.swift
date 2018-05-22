//
//  UIViewController_RecvHeartPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_RecvHeartPage : UIViewController
{
    // TODO 환웅 : 받은 하트 리스트로 뿌려주기
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func RemoveAll(_ sender: Any) {
    }
    @IBOutlet var RecvHeartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*RecvHeartTableView.delegate = self
        RecvHeartTableView.dataSource = self
        RecvHeartTableView.rowHeight = 70;
        RecvHeartTableView.separatorStyle = .none
        
        for i in 0..<DataMgr.Instance.MyData!.FanDataList.count
        {
            DataMgr.Instance.MyData!.FanDataList[i].
            if (DataMgr.Instance.GetCachingUserDataList(index: Int(DataMgr.Instance.MyData!.FavorUserIndexList[i])!) != nil)
            {
                DataMgr.Instance.SetCachingSimpleUserDataList(userData: DataMgr.Instance.GetCachingUserDataList(index: Int(DataMgr.Instance.MyData!.FavorUserIndexList[i])!)!)
            }
            else
            {
                SVProgressHUD.init()
                SVProgressHUD.show()
                FireBaseFunc.Instance.LoadSimpleUserData(index: DataMgr.Instance.MyData!.FavorUserIndexList[i], complete: CallBackFunc_LoadSimpleUserData)
                FavorLoadCnt += 1
            }
        }*/
    }
}
/*
extension UIViewController_RecvHeartPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return (DataMgr.Instance.MyData?.FavorUserIndexList.count)!
        return FavorCnt
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Favor
        
        cell.SetFavorCell(userData: GetSelectSimpleUserData(indexPath:indexPath))
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
            // 로딩하세요
            CommonUIFunc.ShowLoading()
            FireBaseFunc.Instance.LoadUserData(index: DataMgr.Instance.MyData!.FavorUserIndexList[indexPath.row], complete: CallBackFunc_LoadUserData)
        }
    }
}*/
