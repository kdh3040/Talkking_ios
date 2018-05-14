//
//  UITableViewCell_ChatMain.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIViewController_ChatMain : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet var ChatMainTableView: UITableView!
    
    var ChatCnt =  0
    var ChatLoadCnt =  0
    
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == ChatLoadCnt
        {
            SVProgressHUD.dismiss()
            ChatCnt = DataMgr.Instance.MyData!.ChatDataList.count
            ChatMainTableView.reloadData()
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
        ChatMainTableView.delegate = self
        ChatMainTableView.dataSource = self
        ChatMainTableView.rowHeight = 70;
        ChatMainTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataMgr.Instance.MyData?.CahingChatDataList.count)!
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_ChatMain
        
        //cell.SetChatMainCell(userData: GetSelectUserData(indexPath:indexPath), chatData: nil)
        return cell
    }

    
}
