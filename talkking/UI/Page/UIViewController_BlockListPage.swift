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
    // TODO 도형 : 블락 리스트 데이터 필요
    // TODO 환웅 : 블락 리스트 UI 채우기
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
}

extension UIViewController_BlockListPage : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_BlockList
        //cell.SetFavorCell(userData: GetSelectSimpleUserData(indexPath:indexPath))
        return cell
    }
}
