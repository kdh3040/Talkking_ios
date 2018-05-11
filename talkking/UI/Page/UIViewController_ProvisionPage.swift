//
//  UIViewController_ProvisionPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 11..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_ProvisionPage : UIViewController
{

    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var PageTitle: UILabel!
    @IBOutlet var Desc: UITextView!
    
    var ProvisionType : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ProvisionType == 1
        {
            PageTitle.text = "이용 약관"
            Desc.text = ProvisionDesc_1
        }
        else if ProvisionType == 2
        {
            PageTitle.text = "위치정보 이용"
            Desc.text = ProvisionDesc_2
        }
        else
        {
            PageTitle.text = "개인정보 취급방침"
            Desc.text = ProvisionDesc_3
        }
    }
    
    public func SetProvisionType(type : Int)
    {
        ProvisionType = type
    }
    
    let ProvisionDesc_1 = "이용약관 내용 필요"
    let ProvisionDesc_2 = "위치정보 내용 필요"
    let ProvisionDesc_3 = "개인정보 내용 필요"
}
