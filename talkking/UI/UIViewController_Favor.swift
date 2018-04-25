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
        
        DataMgr.Instance
        // 임시
        // 내 데이터 생성
        DataMgr.Instance.MyData = MyUserData(userIndex: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        let count : Int = 0
        
        if(count <= 0)
        {
            tableView.separatorStyle = .none
            //tableView.backgroundView?.isHidden = false
        }
        else
        {
            tableView.separatorStyle = .singleLine
            //tableView.backgroundView?.isHidden = true
        }
        
        
        
        return (DataMgr.Instance.MyData?.MyData?.FavorUserIndexList?.count)!;
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath) as! UITableViewCell_Favor
        
        var index : Int = (DataMgr.Instance.MyData?.MyData?.FavorUserIndexList![indexPath.row])!
        
        cell.SetFavorCell(userData: DataMgr.Instance.GetUserData(index: index)!)
        return cell
    }

}
