//
//  UIViewController_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIViewController_Favor : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var FavorTableView: UITableView!
    
    var FavorCnt =  0
    var FavorLoadCnt =  0
    
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == FavorLoadCnt
        {
            SVProgressHUD.dismiss()
            FavorCnt = DataMgr.Instance.MyData!.FavorUserIndexList.count
            FavorTableView.reloadData()
        }
    }
    
    private func CallBackFunc_LoadUserData(index : Int)
    {
            SVProgressHUD.dismiss()
            let userData : UserData = DataMgr.Instance.GetCachingUserDataList(index: index)!
            let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
            page.SetUserData(userData: userData)
            self.present(page, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FavorTableView.delegate = self
        FavorTableView.dataSource = self
        FavorTableView.rowHeight = 70;
        FavorTableView.separatorStyle = .none
        
        for i in 0..<DataMgr.Instance.MyData!.FavorUserIndexList.count
        {
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : String = DataMgr.Instance.MyData!.FavorUserIndexList[indexPath.row]
        
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: Int(index)!)!
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
            SVProgressHUD.show()
            FireBaseFunc.Instance.LoadUserData(index: DataMgr.Instance.MyData!.FavorUserIndexList[indexPath.row], complete: CallBackFunc_LoadUserData)
        }
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData?
    {
        let index : String = DataMgr.Instance.MyData!.FavorUserIndexList[indexPath.row]
        
        return DataMgr.Instance.GetCachingUserDataList(index: Int(index)!)
    }
}
