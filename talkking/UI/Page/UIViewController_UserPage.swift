//
//  UIViewController_UserPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 3..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_UserPage : UIViewController
{
    
    @IBOutlet var Imagett: UIButton!
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true) {
            print("뒤로감")
        }
    }
    @IBAction func UserPageGOGO(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_PAGE") as! UIViewController_UserPage
        page.TEST()
        self.present(page, animated: true) {
            print("페이지 넘김")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rankIcon = CommonUIFunc.Instance.GetMainRankImgName(rank: 1)
        if rankIcon.isEmpty == false
        {
            Imagett.setImage(UIImage.init(named: rankIcon), for : UIControlState.normal)
        }
    }
    
    public func TEST(){
        print("USER_PAGE")
    }
}
