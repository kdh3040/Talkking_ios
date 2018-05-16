//
//  UIViewController_Fan.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 26..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIViewController_Fan : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var FanTableView: UITableView!
    @IBOutlet var MyFanCount: UILabel!
    @IBOutlet var MyHeartCount: UILabel!
    
    var FanCnt =  0
    var FanLoadCnt =  0
    
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == FanLoadCnt
        {
            CommonUIFunc.DismissLoading()
            FanCnt = DataMgr.Instance.MyData!.FanDataList.count
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
        FanTableView.rowHeight = 70
        FanTableView.separatorStyle = .none
        
        MyFanCount.text = CommonUIFunc.Instance.ConvertNumberFormatDouble(count: DataMgr.Instance.MyData!.FanCount)
        
        MyHeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: DataMgr.Instance.MyData!.RecvHeart)
        
        for i in 0..<DataMgr.Instance.MyData!.FanDataList.count
        {
            if (DataMgr.Instance.GetCachingSimpleUserDataList(index: Int(DataMgr.Instance.MyData!.FanDataList[i].Idx)) == nil)
            {
                CommonUIFunc.ShowLoading()
                FireBaseFunc.Instance.LoadSimpleUserData(index: String(DataMgr.Instance.MyData!.FanDataList[i].Idx), complete: CallBackFunc_LoadSimpleUserData)
                FanLoadCnt += CommonData.LOAD_DATA_SET
            }
        }
        
        if FanLoadCnt == 0
        {
            FanCnt = DataMgr.Instance.MyData!.FanDataList.count
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return (DataMgr.Instance.MyData?.FanDataList.count)!;
        return FanCnt
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Fan
        cell.SetFanCell(userData: GetSelectSimpleUserData(indexPath: indexPath), rank: indexPath.row, RecvHeart: DataMgr.Instance.MyData!.FanDataList[indexPath.row].RecvHeart)
        return cell
    }
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : Int = DataMgr.Instance.MyData!.FanDataList[indexPath.row].Idx
        
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
            // 로딩하세요
            CommonUIFunc.ShowLoading()
            FireBaseFunc.Instance.LoadUserData(index: String(DataMgr.Instance.MyData!.FanDataList[indexPath.row].Idx), complete: CallBackFunc_LoadUserData)
        }
        
        
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData?
    {
        let index = DataMgr.Instance.MyData!.FanDataList[indexPath.row].Idx
        
        return DataMgr.Instance.GetCachingUserDataList(index: index)
    }
    
}
