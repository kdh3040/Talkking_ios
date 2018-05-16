//
//  UIViewController_BoardWritePopup.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_BoardWritePopup : UIViewController_Popup
{
    @IBOutlet var Msg: UITextView!
    @IBAction func Wirte(_ sender: Any) {
        // TODO 게시판 글 쓰기 기능 추가
    }
    @IBAction func Cancel(_ sender: Any) {
        self.DismissPopup()
    }

    var placeholderLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Msg.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = String.init(format:"(%d자 이내)", CommonData.STR_LIMIT_BOARD_MSG)
        placeholderLabel.sizeToFit()
        Msg.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (Msg.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !Msg.text.isEmpty

    }
}

extension UIViewController_BoardWritePopup : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let currentText = textView.text ?? ""
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_BOARD_MSG)
    }
}
