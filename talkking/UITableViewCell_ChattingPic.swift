//
//  UITableViewCell_ChattingPic.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 6. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import UIKit

class UITableViewCell_ChattingPic: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var Pic: UIImageView!
    public func SetChatting(url : String)
    {
        Pic.kf.setImage(with: URL(string: url),
                             placeholder: nil,
                             options: [.transition(.fade(1))],
                             progressBlock: nil,
                             completionHandler: nil)
    }
}
