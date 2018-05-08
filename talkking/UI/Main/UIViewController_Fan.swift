//
//  UIViewController_Fan.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 26..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_Fan : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var FanTableView: UITableView!
    @IBOutlet var MyFanCount: UILabel!
    @IBOutlet var MyHeartCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FanTableView.delegate = self
        FanTableView.dataSource = self
        FanTableView.rowHeight = 70
        FanTableView.separatorStyle = .none
        
        MyFanCount.text = CommonUIFunc.Instance.ConvertNumberFormatDouble(count: DataMgr.Instance.MyData!.FanCount)
        
        MyHeartCount.text = CommonUIFunc.Instance.ConvertNumberFormat(count: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataMgr.Instance.MyData?.FanDataList.count)!;
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Fan
        cell.SetFanCell(userData: GetSelectUserData(indexPath: indexPath), rank: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.SetUserData(userData: GetSelectUserData(indexPath:indexPath))
        self.present(page, animated: true)
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData
    {
        let index = DataMgr.Instance.MyData!.FanDataList[indexPath.row].Idx
        
        return DataMgr.Instance.GetCachingUserDataList(index: index)!
    }
    
}
