//
//  UIViewController_Board.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_Board : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var BoardTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        BoardTableView.delegate = self
        BoardTableView.dataSource = self
        BoardTableView.rowHeight = 70
        BoardTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataMgr.Instance.CachingBoardDataList.count)
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! UITableViewCell_Board
        
        cell.SetBoardCell(boardData: DataMgr.Instance.CachingBoardDataList[indexPath.row])
        return cell
    }
    
}
