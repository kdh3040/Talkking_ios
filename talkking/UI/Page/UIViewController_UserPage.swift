//
//  UIViewController_UserPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 3..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIViewController_UserPage : UIViewController
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
        if let pageUserData = PageUserData,
            let myData = DataMgr.Instance.MyData
        {
            if myData.FavorUserIndexList.contains(String.init(format:"%d", pageUserData.Index))
            {
                let favorRemoveAction = {
                    // TODO : 파이어 베이스에 올리기
                    FireBaseFunc.Instance.DelFavorList(userData : pageUserData)
                    myData.FavorUserIndexList.removeAll()
                    self.RefreshFavorUI()
                }
                
                CommonUIFunc.Instance.ShowAlertPopup(
                    viewController: self,
                    title: "즐겨찾기",
                    message: "즐겨찾기를 해제 하시겠습니까?",
                    actionTitle_1: "해제",
                    actionFunc_1: favorRemoveAction,
                    actionTitle_2: "취소")
            }
            else
            {
                let favorAddAction = {
                    // TODO : 파이어 베이스에 올리기
                    FireBaseFunc.Instance.SetFavorList(userData: pageUserData)
                    myData.FavorUserIndexList.append(String(pageUserData.Index))
                    self.RefreshFavorUI()
                }
                
                CommonUIFunc.Instance.ShowAlertPopup(
                    viewController: self,
                    title: "즐겨찾기",
                    message: "즐겨찾기에 추가 하시겠습니까?",
                    actionTitle_1: "추가",
                    actionFunc_1: favorAddAction,
                    actionTitle_2: "취소")
            }
        }
    }
    @IBOutlet var Favor: UIButton!
    
    @IBAction func ChatAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MSG_SEND_POPUP") as! UIViewController_MsgSendPopup
        page.SetUserData(userData: PageUserData!)
        page.ShowPopup(viewController: self)
    }
    @IBAction func HeartAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "HEART_SEND_POPUP") as! UIViewController_HeartSendPopup
        page.SetUserData(userData: PageUserData!)
        page.ShowPopup(viewController: self)
    }
    @IBAction func ShareAction(_ sender: Any) {
        // TODO 공유하기 기능 추가
    }
    @IBAction func HomeAction(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "HOME_PAGE") as! UIViewController_Home
        self.present(page, animated: true)
    }

    @IBOutlet var FanListView: UICollectionView!
    @IBOutlet var FanListViewFlowLayout: UICollectionViewFlowLayout!
    
    var FanCnt =  0
    var FanLoadCnt =  0
    
    private func CallBackFunc_LoadSimpleUserData(count : Int)
    {
        if count == FanLoadCnt
        {
            CommonUIFunc.DismissLoading()
            FanCnt = PageUserData!.FanDataList.count
            FanListView.reloadData()
            FireBaseFunc.Instance.CallBackCount = 0
        }
    }
    
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
            RefreshFavorUI()
            
            for i in 0..<pageUserData.FanDataList.count
            {
                if (DataMgr.Instance.GetCachingSimpleUserDataList(index: pageUserData.FanDataList[i].Idx) == nil)
                {
                    CommonUIFunc.ShowLoading()
                    FireBaseFunc.Instance.LoadSimpleUserData(index: String.init(format:"%d",pageUserData.FanDataList[i].Idx), complete: CallBackFunc_LoadSimpleUserData)
                    FanLoadCnt += CommonData.LOAD_DATA_SET
                }
            }
            
            if FanLoadCnt == 0
            {
                FanCnt = pageUserData.FanDataList.count
            }
        }
    }
    
    public func RefreshFavorUI()
    {
        if let pageUserData = PageUserData,
        let myData = DataMgr.Instance.MyData
        {
            if myData.FavorUserIndexList.contains(String.init(format:"%d", pageUserData.Index))
            {
                Favor.setImage(UIImage.init(named: "etc_icon_favor"), for: .normal)
            }
            else
            {
                Favor.setImage(UIImage.init(named: "etc_icon_not_favor"), for: .normal)
            }
        }
    }
}

extension UIViewController_UserPage : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FanCnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIViewCollectionCell_UserPage_Fan
        
        if let pageUserData = PageUserData
         {
             let fanIdx = pageUserData.FanDataList[indexPath.row].Idx
             cell.SetUserPageFanData(userData: DataMgr.Instance.GetCachingSimpleUserDataList(index: fanIdx)!)
         }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "USER_FAN_LIST") as! UIViewController_UserFanListPage
        page.SetSelectUserData(userData: PageUserData!)
        self.present(page, animated: true)
    }
}
