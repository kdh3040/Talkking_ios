//
//  VUIViewController_MyUserPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 7..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_MyUserPage : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var UserPageLabel: UILabel!
    
    @IBOutlet var Thumbnail: UIButton!
    @IBAction func Notice(_ sender: Any) {
    }
    @IBOutlet var Name: UILabel!
    @IBOutlet var Grade: UIButton!
    @IBAction func GradeAction(_ sender: Any) {
    }
    @IBAction func ProfileSettinf(_ sender: Any) {
    }
    @IBAction func SettinfAction(_ sender: Any) {
    }
    @IBOutlet var Coin: UILabel!
    @IBAction func CoinCharge(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myData = DataMgr.Instance.MyData
        {
            UserPageLabel.text = String.init(format: "%@의 페이지", myData.Name)
            CommonUIFunc.Instance.SetThumbnail(button: Thumbnail, url: URL(string: myData.GetMainThumbnail())!, circle: true)
            
            CommonUIFunc.Instance.SetUserName(label: Name, userData: myData)
            Grade.setImage(UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:myData.Grade)), for: .normal)
            
            Coin.text = CommonUIFunc.Instance.ConvertNumberFormat(count: myData.Coin)
        }
    }
}
