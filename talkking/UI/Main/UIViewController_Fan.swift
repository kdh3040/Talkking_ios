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

class UIViewController_Fan : UIViewController
{
    @IBOutlet var FanTableView: UITableView!
    @IBOutlet var MyFanCount: UILabel!
    @IBOutlet var MyHeartCount: UILabel!
    
    var FanCnt =  0
    var FanLoadCnt =  0

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
}

extension UIViewController_Fan : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FanCnt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Fan
        cell.SetFanCell(userData: GetSelectSimpleUserData(indexPath: indexPath), rank: indexPath.row, RecvHeart: DataMgr.Instance.MyData!.FanDataList[indexPath.row].RecvHeart)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        CommonUIFunc.Instance.MoveUserPage(index:DataMgr.Instance.MyData!.FanDataList[indexPath.row].Idx, view : self)
    }
}

extension UIViewController_Fan
{
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
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : Int = DataMgr.Instance.MyData!.FanDataList[indexPath.row].Idx
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: (index))!
    }
}
