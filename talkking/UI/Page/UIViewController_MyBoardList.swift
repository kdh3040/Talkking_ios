//
//  UIViewController_MyBoardList.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 21..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_MyBoardList : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet var MyBoardTableView: UITableView!
    
    var BoardView : UIViewController_Board? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MyBoardTableView.delegate = self
        MyBoardTableView.dataSource = self
        MyBoardTableView.rowHeight = UITableViewAutomaticDimension
        MyBoardTableView.estimatedRowHeight = 70
        MyBoardTableView.separatorStyle = .none
    }
    
    public func RefreshUI()
    {
        MyBoardTableView.reloadData()
    }
    public func RefreshBoardUI()
    {
        BoardView!.RefreshUI()
    }
    public func SetBoardView(view : UIViewController_Board)
    {
        BoardView = view
    }
}

extension UIViewController_MyBoardList : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataMgr.Instance.CachingMyBoardDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_MyBoard
        
        cell.SetMyBoardData(boardData: DataMgr.Instance.CachingMyBoardDataList[indexPath.row], view: self)
        return cell
    }
}
