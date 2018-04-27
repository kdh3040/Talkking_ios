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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //ChatMainTableView.delegate = self
        //ChatMainTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count : Int? = DataMgr.Instance.CahingBoardDataList.count
        
        if let realCount = count
        {
            if(realCount <= 0)
            {
                tableView.separatorStyle = .none
                //tableView.backgroundView?.isHidden = false
            }
            else
            {
                tableView.separatorStyle = .singleLine
                //tableView.backgroundView?.isHidden = true
            }
            return realCount
        }
        
        return 0
        
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! UITableViewCell_Board
        
        //let index : int = (DataMgr.Instance.GetBoardData(index: IntDataMgr.Instance.CahingBoardDataList[indexPath.row])!)!
        
        //cell.SetBoardCell(boardIndex: DataMgr.Instance.GetBoardData(index: Int(index)!))
        return cell
    }
    
}
