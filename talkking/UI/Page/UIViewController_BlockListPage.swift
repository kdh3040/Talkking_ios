//
//  UIViewController_BlockListPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_BlockListPage : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var BlockList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BlockList.delegate = self
        BlockList.dataSource = self
        BlockList.rowHeight = 70;
        BlockList.separatorStyle = .none
    }
    
    public func RefreshUI()
    {
        BlockList.reloadData()
    }
}

extension UIViewController_BlockListPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataMgr.Instance.MyData!.BlockDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_BlockList
        cell.SetBlockList(DataMgr.Instance.MyData!.BlockDataList[indexPath.row], view : self)
        return cell
    }
}

