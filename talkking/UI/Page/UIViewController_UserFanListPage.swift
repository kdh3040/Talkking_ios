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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FanTableView.delegate = self
        FanTableView.dataSource = self
        FanTableView.rowHeight = 80;
        FanTableView.separatorStyle = .none
    }
    
    public func SetSelectUserData(userData : UserData)
    {
        SelectUserData = userData
    }
}

extension UIViewController_UserFanListPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectUserData!.FanDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_UserFan
        let fanData = SelectUserData!.FanDataList[indexPath.row]
        if let userData = DataMgr.Instance.GetCachingUserDataList(index:fanData.Idx)
        {
            cell.SetFanUserData(userData: userData, rank : indexPath.row, RecvHeart: fanData.RecvHeart)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.SetUserData(userData: DataMgr.Instance.GetCachingUserDataList(index:SelectUserData!.FanDataList[indexPath.row].Idx)!)
        self.present(page, animated: true)
    }
}
