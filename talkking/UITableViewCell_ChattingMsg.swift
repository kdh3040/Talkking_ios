//
//  UITableViewCell_ChattingMsg.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 6. 2..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import UIKit

class UITableViewCell_ChattingMsg: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet var Msg: UILabel!
    public func SetChatting(msg:String)
    {
        Msg.text = msg
    }
}
