//
//  UIViewController_Chatting.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 6. 1..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_Chatting: UIViewController
{
    struct MSG_TEST {
        var chat_type : Int = 0
        var Msg : String = ""
    }
    
    @IBOutlet var ChattingTableView: UITableView!
    
    @IBOutlet var ChattingMsg: UITextField!
    @IBAction func SendAction(_ sender: Any) {
        
        dismissKeyboard()
        
        var test = MSG_TEST()
        test.chat_type = Int(arc4random_uniform(4))
        test.Msg = ChattingMsg.text!
        MSG.append(test)
        ChattingMsg.text = ""
        ChattingTableView.reloadData()
        
        moveToBottom()
    }
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    var MSG : [MSG_TEST] = [MSG_TEST]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChattingTableView.delegate = self
        ChattingTableView.dataSource = self
        ChattingTableView.rowHeight = UITableViewAutomaticDimension
        ChattingTableView.estimatedRowHeight = 300
        ChattingTableView.separatorStyle = .none
        
        ChattingTableView.register(UINib(nibName: "UITableViewCell_ChattingMsg", bundle: nil), forCellReuseIdentifier: "cell")
        ChattingTableView.register(UINib(nibName: "UITableViewCell_ChattingPic", bundle: nil), forCellReuseIdentifier: "pic_cell")
        ChattingTableView.register(UINib(nibName: "UITableViewCell_OtherChattingMsg", bundle: nil), forCellReuseIdentifier: "other_cell")
        ChattingTableView.register(UINib(nibName: "UITableViewCell_OtherChattingPic", bundle: nil), forCellReuseIdentifier: "other_pic_cell")

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            
            self.moveToBottom()
        }
        
    }
    
    @objc func keyboardWillShow(notify: NSNotification) {
        
        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0 {
                
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notify: NSNotification) {
        
        if let keyboardSize = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y != 0 {
                
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func moveToBottom() {
        
        if MSG.count > 0  {
            
            let indexPath = IndexPath(row: MSG.count - 1, section: 0)
            
            ChattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
}

extension UIViewController_Chatting : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MSG.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let chatData = MSG[indexPath.row]
        switch chatData.chat_type {
        case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "pic_cell", for: indexPath) as! UITableViewCell_ChattingPic
                
                cell.SetChatting(url: "https://firebasestorage.googleapis.com/v0/b/talkking-25dd8.appspot.com/o/images%2F1671%2F0?alt=media&token=462742d2-5183-4fe6-a725-d12e8b9ee331")
                
                return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_ChattingMsg
            
            cell.SetChatting(msg: chatData.Msg)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "other_pic_cell", for: indexPath) as! UITableViewCell_OtherChattingPic
            cell.SetChatting(userData: DataMgr.Instance.MyData!, url: "https://firebasestorage.googleapis.com/v0/b/talkking-25dd8.appspot.com/o/images%2F1671%2F0?alt=media&token=462742d2-5183-4fe6-a725-d12e8b9ee331")
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "other_cell", for: indexPath) as! UITableViewCell_OtherChattingMsg
            
            cell.SetChatting(userData: DataMgr.Instance.MyData!, msg: chatData.Msg)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell_ChattingMsg
            
            cell.SetChatting(msg: chatData.Msg)
            return cell
        }
    }
}
