//
//  UITableViewCell_Favor.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 23..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewCell_Favor : UITableViewCell
{
    @IBAction func FavorButton(_ sender: Any) {
        print("asdfasdf")
    }
    @IBOutlet var Grade: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Thumbnail: UIImageView!
    
    public func SetFavorCell(userData:UserData)
    {
        Name.text = userData.Name
        //Thumbnail = UIImage.
    }
}
