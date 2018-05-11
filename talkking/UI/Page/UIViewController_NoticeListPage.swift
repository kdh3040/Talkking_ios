//
//  UIViewController_NoticePage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 11..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_NoticeListPage : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBOutlet var NoticeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view, typically from a nib.
        NoticeTableView.delegate = self
        NoticeTableView.dataSource = self
        NoticeTableView.separatorStyle = .none
    }
}

extension UIViewController_NoticeListPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_Notice
        
        cell.SetNoticeData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "NOTICE_PAGE") as! UIViewController_NoticePage
        page.SetNotice()
        self.present(page, animated: true)
    }
}
