//
//  UIViewController_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_Favor : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var FavorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FavorTableView.delegate = self
        FavorTableView.dataSource = self
        FavorTableView.rowHeight = 70;
        FavorTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataMgr.Instance.MyData?.FavorUserIndexList.count)!
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath) as! UITableViewCell_Favor
        
        let index : String = (DataMgr.Instance.MyData?.FavorUserIndexList[indexPath.row])!
        
        cell.SetFavorCell(userData: DataMgr.Instance.GetCachingUserDataList(index: Int(index)!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.TEST()
        self.present(page, animated: true) {
            print("페이지 넘김")
        }
    }

}
