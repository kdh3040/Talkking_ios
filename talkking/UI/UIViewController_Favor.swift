//
//  UIViewController_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class ttet : PagingViewController
{
    
}
class UIViewController_Favor : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var FavorTableEmptyView: UIView!
    @IBOutlet var FavorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FavorTableView.delegate = self
        FavorTableView.dataSource = self
        FavorTableView.backgroundView = FavorTableEmptyView
        
        FavorTableEmptyView.center = self.view.center
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        let count : Int = 0
        
        if(count <= 0)
        {
            tableView.separatorStyle = .none
            //tableView.backgroundView?.isHidden = false
        }
        else
        {
            tableView.separatorStyle = .singleLine
            //tableView.backgroundView?.isHidden = true
        }
        
        return 0;
    }
    // 셀 내용 변경하기 (tableView 구현 필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorCell", for: indexPath) as! UITableViewCell_Favor
        
        cell.Name.text = "124124"
        return cell
    }

}
