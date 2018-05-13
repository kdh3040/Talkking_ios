//
//  UIviewController_Home_FanCount.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit


class UIViewController_Home_FanCount: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet var collectionview: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataMgr.Instance.GetUserDataList_FanCount_Count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:UIViewCollectionCell_Home_FanCount = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIViewCollectionCell_Home_FanCount
        
        cell.SetHomeFanCountData(userIndex:DataMgr.Instance.GetUserDataList_FanCount(index: indexPath.row), rank : indexPath.row + 1)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        CommonUIFunc.Instance.PushUserPage(userData: GetSelectUserData(indexPath:indexPath), viewController:self)
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData
    {
        let index = DataMgr.Instance.GetUserDataList_FanCount(index: indexPath.row)
        
        return DataMgr.Instance.GetCachingUserDataList(index: index)!
    }
}
