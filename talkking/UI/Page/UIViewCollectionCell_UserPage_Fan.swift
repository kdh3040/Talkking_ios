//
//  UIViewCollectionCell_UserPage_Fan\.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewCollectionCell_UserPage_Fan : UICollectionViewCell
{
    @IBOutlet var Thumbnail: UIImageView!
    public func SetUserPageFanData(userData:UserData)
    {
        CommonUIFunc.Instance.SetThumbnail(imageView: Thumbnail, url: URL(string:userData.GetMainThumbnail())!, circle: true)
    }
}
