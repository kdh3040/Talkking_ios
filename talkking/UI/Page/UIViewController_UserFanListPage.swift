//
//  UIViewController_UserFanListPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_UserFanListPage : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var PageNameLabel: UILabel!
    
    @IBOutlet var HeartCount: UILabel!
    @IBOutlet var FanCount: UILabel!
    @IBOutlet var FanTableView: UITableView!
    
    public var SelectUserData : UserData? = nil
    var FanCnt =  0
    var FanLoadCnt =  0
    
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == FanLoadCnt,
            let userData = self.SelectUserData
        {
            CommonUIFunc.DismissLoading()
            FanCnt = userData.FanDataList.count
            FanTableView.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FanTableView.delegate = self
        FanTableView.dataSource = self
        FanTableView.rowHeight = 80;
        FanTableView.separatorStyle = .none
        
        if let userData = SelectUserData
        {
            PageNameLabel.text = String.init(format:"%@의 팬", userData.Name)
            HeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: userData.RecvHeart)
            FanCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: userData.FanDataList.count)
            
            for i in 0..<userData.FanDataList.count
            {
                let fanData = userData.FanDataList[i]
                if (DataMgr.Instance.GetCachingSimpleUserDataList(index: fanData.Idx) == nil)
                {
                    CommonUIFunc.ShowLoading()
                    FireBaseFunc.Instance.LoadSimpleUserData(index: String(fanData.Idx), complete: CallBackFunc_LoadSimpleUserData)
                    FanLoadCnt += CommonData.LOAD_DATA_SET
                }
            }
            
            if FanLoadCnt == 0
            {
                FanCnt = userData.FanDataList.count
            }
        }
        
    }
    
    public func SetSelectUserData(userData : UserData)
    {
        SelectUserData = userData
    }
}

extension UIViewController_UserFanListPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FanCnt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_UserFan
        let fanData = SelectUserData!.FanDataList[indexPath.row]
        cell.SetFanUserData(userData: GetSelectSimpleUserData(indexPath: indexPath) , rank : indexPath.row, RecvHeart: fanData.RecvHeart)
        return cell
    }
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : Int = SelectUserData!.FanDataList[indexPath.row].Idx
        
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: (index))!
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
            FireBaseFunc.Instance.LoadUserData(index: String(SelectUserData!.FanDataList[indexPath.row].Idx), complete: CallBackFunc_LoadUserData)
        }
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData?
    {
        let index = SelectUserData!.FanDataList[indexPath.row].Idx
        
        return DataMgr.Instance.GetCachingUserDataList(index: index)
    }
}
