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

class UIViewController_Favor : UIViewController
{
    @IBOutlet var FavorTableView: UITableView!

    var FavorCnt =  0
    var FavorLoadCnt =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FavorTableView.delegate = self
        FavorTableView.dataSource = self
        FavorTableView.rowHeight = 70;
        FavorTableView.separatorStyle = .none
        
        for i in 0..<DataMgr.Instance.MyData!.FavorUserIndexList.count
        {
            if (DataMgr.Instance.GetCachingSimpleUserDataList(index: Int(DataMgr.Instance.MyData!.FavorUserIndexList[i])!) == nil)
            {
                CommonUIFunc.ShowLoading()
                FireBaseFunc.Instance.LoadSimpleUserData(index: DataMgr.Instance.MyData!.FavorUserIndexList[i], complete: CallBackFunc_LoadSimpleUserData)
                FavorLoadCnt += CommonData.LOAD_DATA_SET
            }
        }
        
        if FavorLoadCnt == 0
        {
            FavorCnt = DataMgr.Instance.MyData!.FavorUserIndexList.count
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIViewController_Favor : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavorCnt
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Favor
        
        cell.SetFavorCell(userData: GetSelectSimpleUserData(indexPath:indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CommonUIFunc.Instance.MoveUserPage(index:Int(DataMgr.Instance.MyData!.FavorUserIndexList[indexPath.row])!, view : self)
    }
}

extension UIViewController_Favor
{
    // 파이어 베이스 콜백 함수
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == FavorLoadCnt
        {
            CommonUIFunc.DismissLoading()
            FavorCnt = DataMgr.Instance.MyData!.FavorUserIndexList.count
            FavorTableView.reloadData()
            FireBaseFunc.Instance.CallBackCount = 0
        }
    }
    
    func GetSelectSimpleUserData(indexPath: IndexPath) -> UserData
    {
        let index : String = DataMgr.Instance.MyData!.FavorUserIndexList[indexPath.row]
        
        return DataMgr.Instance.GetCachingSimpleUserDataList(index: Int(index)!)!
    }
}
