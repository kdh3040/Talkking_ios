//
//  UITableViewController_Setting.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewController_Setting : UITableViewController
{
    @IBOutlet var AlarmSound: UISwitch!
    @IBOutlet var AlarmVibration: UISwitch!
    @IBOutlet var AlarmPopup: UISwitch!
    @IBOutlet var MsgRefusal: UISwitch!
    @IBAction func BlockListAction(_ sender: Any) {
        // TODO 차단 목록 관리
    }
    @IBAction func ShareAction(_ sender: Any) {
        // TODO 공유
        
    }
    @IBAction func CoinChargeAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "CHARGE_PAGE") as! UIViewController_ChargePage
        self.present(page, animated: true)
    }
    @IBAction func ProvisionAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:1)
        self.present(page, animated: true)
    }
    @IBAction func HelpAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:4)
        self.present(page, animated: true)
    }
    @IBAction func DeleteUserAction(_ sender: Any) {
        // TODO 계정 삭제
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
