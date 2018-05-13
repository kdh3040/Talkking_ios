//
//  UIViewController_UserPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 3..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_UserPage : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var UserNamePage: UILabel!
    @IBAction func ThumbnailAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "THUMBNAIL_LIST_PAGE") as! UIViewController_ThumbnailList
        page.SetUserThumbnailList(userData: PageUserData!)
        self.present(page, animated: true)
    }
    @IBOutlet var Thumbnail: UIButton!
    @IBOutlet var Distance: UILabel!
    @IBOutlet var Name: UILabel!
    @IBOutlet var BestItem: UIImageView!
    @IBOutlet var Grade: UIImageView!
    
    @IBAction func FavorAction(_ sender: Any) {
    }
    @IBOutlet var Favor: UIButton!
    
    @IBAction func ChatAction(_ sender: Any) {
    }
    @IBAction func HeartAction(_ sender: Any) {
    }
    @IBAction func ShareAction(_ sender: Any) {
    }
    @IBAction func HomeAction(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "HOME_PAGE") as! UIViewController_Home
        self.present(page, animated: true)
    }

    @IBOutlet var FanListView: UICollectionView!
    @IBOutlet var FanListViewFlowLayout: UICollectionViewFlowLayout!
    
    var PageUserData : UserData? = nil
    public func SetUserData(userData : UserData)
    {
        PageUserData = userData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FanListView.delegate = self
        FanListView.dataSource = self
        FanListView.collectionViewLayout = FanListViewFlowLayout
        
        if let pageUserData = PageUserData
        {
            UserNamePage.text = String.init(format: "%@의 페이지", pageUserData.Name)
            CommonUIFunc.Instance.SetThumbnail(button: Thumbnail, url: URL(string: pageUserData.GetMainThumbnail())!, circle: false)
            Distance.text = CommonUIFunc.Instance.ConvertNumberFormatDouble(count: pageUserData.Distance, addString: "Km")
            CommonUIFunc.Instance.SetUserName(label: Name, userData:pageUserData)
            Grade.image = UIImage.init(named: CommonUIFunc.Instance.GetGradeImgName(grade:pageUserData.Grade))
            BestItem.image = UIImage.init(named: CommonUIFunc.Instance.GetItemImgName(bestItem: pageUserData.BestItem))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PageUserData!.FanDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIViewCollectionCell_UserPage_Fan
        
        /*if let pageUserData = PageUserData
        {
            let fanIdx = pageUserData.FanDataList[indexPath.row].Idx
            cell.SetUserPageFanData(userData: DataMgr.Instance.GetCachingUserDataList(index: fanIdx)!)
        }*/
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // 팬 페이지로 이동
    }
}
