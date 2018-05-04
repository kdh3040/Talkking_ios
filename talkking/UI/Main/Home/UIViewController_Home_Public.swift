//
//  UIViewController_Home_Public.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit


class UIViewController_Home_Public: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{

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
        return DataMgr.Instance.GetUserDataList_RecvHeart_Count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIViewCollectionCell_Home_Public
        
        cell.SetHomePublicData(userIndex:DataMgr.Instance.GetUserDataList_RecvHeart(index: indexPath.row), rank : indexPath.row + 1)
        return cell
    }
}