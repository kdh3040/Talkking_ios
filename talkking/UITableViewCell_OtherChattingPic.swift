//
//  UITableViewCell_OtherChattingPic.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 6. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import UIKit

class UITableViewCell_OtherChattingPic: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var Thumbnail: UIImageView!
    @IBOutlet var Name: UILabel!
    @IBOutlet var Pic: UIImageView!
    
    public func SetChatting(userData : UserData, url : String)
    {
        CommonUIFunc.Instance.SetThumbnail(imageView: Thumbnail, url: URL(string:userData.GetMainThumbnail())!, circle: true)
        Name.text = userData.Name
        Pic.kf.setImage(with: URL(string: url),
                        placeholder: nil,
                        options: [.transition(.fade(1))],
                        progressBlock: nil,
                        completionHandler: nil)
    }
    
}
