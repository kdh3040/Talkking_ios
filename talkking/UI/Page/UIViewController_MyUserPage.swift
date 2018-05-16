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
    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var UserPageLabel: UILabel!
    
    @IBAction func ThumbnailAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "THUMBNAIL_LIST_PAGE") as! UIViewController_ThumbnailList
        page.SetUserThumbnailList(userData: DataMgr.Instance.MyData!)
        self.present(page, animated: true)
    }
    @IBOutlet var Thumbnail: UIButton!
    @IBAction func Notice(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "NOTICE_LIST_PAGE") as! UIViewController_NoticeListPage
        self.present(page, animated: true)
    }
    @IBOutlet var Name: UILabel!
    @IBOutlet var Grade: UIButton!
    @IBAction func GradeAction(_ sender: Any) {
        // TODO 등급표 팝업 추가
    }
    @IBOutlet var BestItem: UIButton!
    @IBAction func BestItemAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MY_JEWEL_PAGE") as! UIViewController_MyJewel
        self.present(page, animated: true)
    }
    @IBAction func ProfileSetting(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROFILE_SETTING_PAGE") as! UIViewController_ProfileSetting
        self.present(page, animated: true)
    }
    @IBAction func SettingAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "SETTING_PAGE") as! UIViewController_SettingPage
        self.present(page, animated: true)
        
    }
    
    @IBAction func CoinCharge(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "CHARGE_PAGE") as! UIViewController_ChargePage
        self.present(page, animated: true)
    }
    
    @IBOutlet var Coin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myData = DataMgr.Instance.MyData
        {
            UserPageLabel.text = String.init(format: "%@의 페이지", myData.Name)
            CommonUIFunc.Instance.SetThumbnail(button: Thumbnail, url: URL(string: myData.GetMainThumbnail())!, circle: true)
            
            CommonUIFunc.Instance.SetUserName(label: Name, userData: myData)
            Grade.setImage(UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:myData.Grade)), for: .normal)
            BestItem.setImage(UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem:myData.BestItem)), for: .normal)
            
            Coin.text = CommonUIFunc.Instance.ConvertNumberFormat(count: myData.Coin)
        }
    }
}
