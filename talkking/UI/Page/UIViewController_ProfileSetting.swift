//
//  UIViewController_ProfileSetting.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 12..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_ProfileSetting : UIViewController
{
    @IBAction func Back(_ sender: Any) {
        self.SaveSetting()
    }
    @IBAction func Save(_ sender: Any) {
        self.SaveSetting()
    }
    @IBOutlet var MainThumbnail: UIButton!
    @IBAction func MainThumbnailAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "THUMBNAIL_LIST_PAGE") as! UIViewController_ThumbnailList
        page.SetUserThumbnailList(thumbnailList:ThumbnailImg)
        self.present(page, animated: true)
    }
    @IBOutlet var SubThumbnail_1: UIButton!
    @IBAction func SubThumbnailAction_1(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_1, index :0)
    }
    @IBOutlet var SubThumbnail_2: UIButton!
    @IBAction func SubThumbnailAction_2(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_2, index :1)
    }
    @IBOutlet var SubThumbnail_3: UIButton!
    @IBAction func SubThumbnailAction_3(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_3, index :2)
    }
    @IBOutlet var SubThumbnail_4: UIButton!
    @IBAction func SubThumbnailAction_4(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_4, index :3)
    }
    @IBOutlet var NickName: UILabel!
    @IBAction func NickNameChangeAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "NICK_NAME_CHANGE_POPUP") as! UIViewController_NickNameChangePopup
        page.ShowPopup(viewController: self)
    }
    @IBOutlet var Age: UITextField!
    @IBOutlet var Gander: UILabel!
    @IBOutlet var Desc: UITextView!
    
    let ThumbnailPicker = UIImagePickerController()
    var placeholderLabel : UILabel!
    let AgePickerView = UIPickerView()
    
    var SelectSubThumbnail : UIButton? = nil
    var SelectSubThumbnailIndex : Int = -1
    
    var ChangeThumbnail = false
    var ChangeMsg = false
    var ChangeAge = false
    
    var ThumbnailImg : [Int : UIImage?] = [Int : UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ThumbnailPicker.delegate = self
        
        Desc.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = String.init(format:"(%d자 이내)", CommonData.STR_LIMIT_MYPROFILE_MEMO)
        placeholderLabel.sizeToFit()
        Desc.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (Desc.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !Desc.text.isEmpty
        
        Age.inputView = AgePickerView
        AgePickerView.dataSource = self
        AgePickerView.delegate = self
        
        if let myData = DataMgr.Instance.MyData
        {
            NickName.text = myData.Name
            Age.text = String.init(format:"%d세", myData.Age)
            Gander.text = myData.Gender.rawValue
            Desc.text = myData.Memo
            
            CommonUIFunc.Instance.SetThumbnail(button: MainThumbnail, url:URL(string:myData.GetMainThumbnail())!, circle: false)
            
            ThumbnailImg.removeAll()
            let subThumbnailList = myData.GetThumbnailList()
            for i in 0..<subThumbnailList.count
            {
                if subThumbnailList[i] != "1"
                {
                    switch(i)
                    {
                    case 1:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_1, url:URL(string:subThumbnailList[i])!, circle: false)
                        ThumbnailImg[0] = SubThumbnail_1.backgroundImage(for: .normal)
                        break;
                    case 2:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_2, url:URL(string:subThumbnailList[i])!, circle: false)
                        ThumbnailImg[1] = SubThumbnail_2.backgroundImage(for: .normal)
                        break;
                    case 3:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_3, url:URL(string:subThumbnailList[i])!, circle: false)
                        ThumbnailImg[2] = SubThumbnail_3.backgroundImage(for: .normal)
                        break;
                    case 4:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_4, url:URL(string:subThumbnailList[i])!, circle: false)
                        ThumbnailImg[3] = SubThumbnail_4.backgroundImage(for: .normal)
                        break;
                    default:
                        break;
                    }
                }
            }
        }
    }
    
    public func SetThumbnail(button : UIButton, index : Int)
    {
        self.SelectSubThumbnail = button
        self.SelectSubThumbnailIndex = index
        
        let thumbnailChange = {
            CommonUIFunc.Instance.OpenThumbnailPic(viewController: self, thumbnailPicker: self.ThumbnailPicker)
        }
        
        let thumbnailDelete = {
            if let thumbnail = self.SelectSubThumbnail
            {
                thumbnail.setBackgroundImage(UIImage.init(named: "etc_icon_picture"), for: .normal)
                self.ThumbnailImg[self.SelectSubThumbnailIndex] = nil
                self.ChangeThumbnail = true
            }
        }
        
        CommonUIFunc.Instance.ShowAlertPopup(
            viewController: self,
            title: "썸네일 변경",
            message: "썸네일을 변경 하시겠습니까?",
            actionTitle_1: "변경",
            actionFunc_1: thumbnailChange,
            actionTitle_2: "삭제",
            actionFunc_2: thumbnailDelete)
    }
    
    public func SaveSetting()
    {
        if ChangeThumbnail || ChangeMsg || ChangeAge
        {
            let saveAction = {
                // TODO 도형 : 프로필 변경 저장
                self.dismiss(animated: true)
            }
            let cancelAction = {
                self.dismiss(animated: true)
            }
            
            CommonUIFunc.Instance.ShowAlertPopup(
                viewController: self,
                title: "프로필",
                message: "변경된 프로필을 저장 하시겠습니까?",
                actionTitle_1: "네",
                actionFunc_1: saveAction,
                actionTitle_2: "아니요",
                actionFunc_2: cancelAction)
        }
        else
        {
            self.dismiss(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIViewController_ProfileSetting : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            if let thumbnail = SelectSubThumbnail
            {
                thumbnail.setBackgroundImage(image, for: .normal)
                self.ThumbnailImg[SelectSubThumbnailIndex] = image
                self.ChangeThumbnail = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension UIViewController_ProfileSetting : UIPickerViewDataSource, UIPickerViewDelegate
{
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CommonData.AGE_DATA.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CommonData.AGE_DATA[row] + "세"
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Age.text = CommonData.AGE_DATA[row] + "세"
        
        if let myData = DataMgr.Instance.MyData
        {
            if myData.Age - 20 == row
            {
                self.ChangeAge = false
            }
            else
            {
                self.ChangeAge = true
            }
        }
    }
}
extension UIViewController_ProfileSetting : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let currentText = textView.text ?? ""
        
        if let myData = DataMgr.Instance.MyData
        {
            if myData.Memo == currentText
            {
                self.ChangeMsg = false
            }
            else
            {
                self.ChangeMsg = true
            }
        }
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_MYPROFILE_MEMO)
    }
}
