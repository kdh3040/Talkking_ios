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
    // TODO 도형 : 내가 쓴 게시판 데이터 필요
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet var MyBoardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MyBoardTableView.delegate = self
        MyBoardTableView.dataSource = self
        MyBoardTableView.rowHeight = UITableViewAutomaticDimension
        MyBoardTableView.estimatedRowHeight = 70
        MyBoardTableView.separatorStyle = .none
    }
}

extension UIViewController_MyBoardList : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_MyBoard
        
        //cell.SetBoardCell(boardData: DataMgr.Instance.CachingBoardDataList[indexPath.row], view : self)
        return cell
    }
}
