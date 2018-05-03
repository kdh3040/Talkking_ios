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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FanCell", for: indexPath) as! UITableViewCell_Fan

        //let index : Int = (DataMgr.Instance.MyData?.FavorUserIndexList[indexPath.row])!
        
        //let userData : UserData = DataMgr.Instance.GetCachingUserDataList(index: index)!
        
        //cell.SetFanCell(userData: userData, rank: index)
        return cell
    }
    
}
