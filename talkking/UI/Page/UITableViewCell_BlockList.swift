//
//  UITableViewCell_BlockList.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_BlockList : UITableViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBAction func BlockCancelAction(_ sender: Any) {
        // TODO 환웅 : 블락 제거 하고 리스트 갱신
        DataMgr.Instance.MyData!.RemoveBlockList(idx:Idx)
        View!.RefreshUI()
    }
    
    var Idx : Int = 0
    var View : UIViewController_BlockListPage? = nil
    
    public func SetBlockList(_ blockData : BlockData, view : UIViewController_BlockListPage)
    {
        View = view
        Idx = blockData.Idx
        CommonUIFunc.Instance.SetThumbnail(imageView: Thumbnail, url: URL(string:blockData.Img)!, circle: true)
        Name.text = blockData.NickName
    }
}
