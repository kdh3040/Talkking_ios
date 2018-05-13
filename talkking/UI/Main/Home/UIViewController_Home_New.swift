//
//  UIviewController_Home_New.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_Home_New: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataMgr.Instance.GetUserDataList_New_Count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //UIcollectionviewcell * cell = collectionview.de "cell"
        
        let cell:UIViewCollectionCell_Home_New = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIViewCollectionCell_Home_New
        cell.SetHomeNewData(userIndex: DataMgr.Instance.GetUserDataList_New(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        CommonUIFunc.Instance.PushUserPage(userData: GetSelectUserData(indexPath:indexPath), viewController:self)
    }
    
    func GetSelectUserData(indexPath: IndexPath) -> UserData
    {
        let index = DataMgr.Instance.GetUserDataList_New(index: indexPath.row)
        
        return DataMgr.Instance.GetCachingUserDataList(index: index)!
    }
}
