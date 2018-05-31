//
//  UITabBarController_Main.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 28..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITabBarController_Main : UITabBarController
{
    @IBOutlet var MainTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        CommonUIFunc.MainTabBarController = self
        RefreshTabBar()
    }
    
    public func RefreshTabBar()
    {
        for i in 0..<MainTabBar.items!.count
        {
            if i == 1
            {
                // 즐겨찾기
                if let myData = DataMgr.Instance.MyData
                {
                    MainTabBar.items![i].badgeValue = myData.NewFavorUserIndexList.count > 0 ? " " : nil
                }
            }
            else if i == 2
            {
                // 채팅
            }
            else if i == 3
            {
                // 팬
                if let myData = DataMgr.Instance.MyData
                {
                    let badgeEnable = myData.NewFanDataList.count > 0 || myData.UpdateFanDataList.count > 0
                    MainTabBar.items![i].badgeValue = badgeEnable ? " " : nil
                }
            }
        }
    }
    
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        if item.tag == 1
        {
            // 즐겨찾기
            if let myData = DataMgr.Instance.MyData
            {
                myData.NewFavorUserIndexList.removeAll()
                RefreshTabBar()
            }
            
            CommonUIFunc.Instance.RefreshMainFavor()
        }
        else if item.tag == 2
        {
            // 채팅
        }
        else if item.tag == 3
        {
            // 팬
            CommonUIFunc.Instance.RefreshMainFan()
        }
        
    }
}
