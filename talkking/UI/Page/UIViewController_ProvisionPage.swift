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
        
        var fileName = ""
        if ProvisionType == 1
        {
            PageTitle.text = "이용 약관"
            fileName = "Access_Term"
        }
        else if ProvisionType == 2
        {
            PageTitle.text = "위치정보 이용"
            fileName = "Location_Term"
        }
        else if ProvisionType == 3
        {
            PageTitle.text = "개인정보 취급방침"
            fileName = "Privacy"
        }
        else
        {
            PageTitle.text = "도움말 및 고객 지원"
            fileName = "Activity_help"
        }
        
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt")
        {
            do {
                let contents = try String(contentsOfFile: filePath, encoding: .utf8)
                Desc.text = contents
            }
            catch
            {
                
            }
        }
        
    }
    
    public func SetProvisionType(type : Int)
    {
        ProvisionType = type
    }
}
