//
//  UIViewController_RecvHeartPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_RecvHeartPage : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func RemoveAll(_ sender: Any) {

        let MsgDelete = {
            if let myData = DataMgr.Instance.MyData
            {
                FireBaseFunc.Instance.RemoveAllRecvHeartData()
                myData.RemoveAllRecvHeartData()
                self.RefreshUI()
            }
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: self,
            title: "메세지 삭제",
            message: "메세지를 전체삭제 하시겠습니까?",
            actionTitle_1: "삭제",
            actionFunc_1: MsgDelete,
            actionTitle_2: "취소")
        
    }
    @IBOutlet var RecvHeartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        RecvHeartTableView.delegate = self
        RecvHeartTableView.dataSource = self
        RecvHeartTableView.rowHeight = 70;
        RecvHeartTableView.separatorStyle = .none
    }
    
    public func RefreshUI()
    {
        RecvHeartTableView.reloadData()
    }
}

extension UIViewController_RecvHeartPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataMgr.Instance.MyData!.RecvHeartList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_RecvHeart
        
        cell.SetRecvHeart(DataMgr.Instance.MyData!.RecvHeartList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MSG_POPUP") as! UIViewController_RecvMsgPopup
        page.SetRecvHeartData(data: DataMgr.Instance.MyData!.RecvHeartList[indexPath.row])
        page.ShowPopup(viewController: self)
    }
}
