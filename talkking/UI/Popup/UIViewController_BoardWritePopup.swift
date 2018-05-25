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
    @IBAction func Write(_ sender: Any) {
        if CommonUIFunc.Instance.IsStringEmptyCheck(text: Msg.text)
        {
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "게시판 글쓰기",
                message: "게시글의 내용이 없습니다.",
                actionTitle_1: "확인")
        }
        else
        {
            let writeFunc = {
                FireBaseFunc.Instance.WriteBoard(msg: self.Msg.text, complete: {
                    DispatchQueue.main.async {
                        self.boardListView!.RefreshUI()
                    }
                })
                
                self.DismissPopup()
            }
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "게시판 글쓰기",
                message: String.init(format:"작성한 글을 게시하시겠습니까?\n도배방지를 위해 다음 글은 %d분후에 쓰실수 있습니다.", CommonData.BOARD_WIRTE_LIMIT_TIME_MIN),
                actionTitle_1: "확인",
                actionFunc_1: writeFunc,
                actionTitle_2: "취소")
        }
    }
    @IBAction func Cancel(_ sender: Any) {
        self.DismissPopup()
    }

    var placeholderLabel : UILabel!
    var boardListView : UIViewController_Board? = nil
    
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
    
    public func SetBoardView(view : UIViewController_Board)
    {
        boardListView = view
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
