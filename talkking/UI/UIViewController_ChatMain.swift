//
//  UITableViewCell_ChatMain.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_ChatMain : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var ChatMainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ChatMainTableView.delegate = self
        ChatMainTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count : Int = (DataMgr.Instance.MyData?.CahingChatDataList.count)!
        
        if(count <= 0)
        {
            tableView.separatorStyle = .none
        }
        else
        {
            tableView.separatorStyle = .singleLine
        }

        return count
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! UITableViewCell_ChatMain
        
        let data : ChatData = (DataMgr.Instance.MyData?.CahingChatDataList[indexPath.row])!
        
        cell.SetChatMainCell(chatdata: data)
        return cell
    }
    
}
