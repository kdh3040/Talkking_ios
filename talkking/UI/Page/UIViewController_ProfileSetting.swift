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
    // TODO 변경된 데이터를 파이어베이스에 올리는 기능
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func Save(_ sender: Any) {
        // TODO : 실제로 데이터가 변경 되었다면 저장 확인 팝업
        // 아니면 그냥 뒤로가기
        self.dismiss(animated: true)
    }
    @IBOutlet var MainThumbnail: UIButton!
    @IBAction func MainThumbnailAction(_ sender: Any) {
        // TODO : 현재 올린거를 리스트로 보여줘야함
        let page = self.storyboard?.instantiateViewController(withIdentifier: "THUMBNAIL_LIST_PAGE") as! UIViewController_ThumbnailList
        page.SetUserThumbnailList(userData: DataMgr.Instance.MyData!)
        self.present(page, animated: true)
    }
    @IBOutlet var SubThumbnail_1: UIButton!
    @IBAction func SubThumbnailAction_1(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_1)
    }
    @IBOutlet var SubThumbnail_2: UIButton!
    @IBAction func SubThumbnailAction_2(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_2)
    }
    @IBOutlet var SubThumbnail_3: UIButton!
    @IBAction func SubThumbnailAction_3(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_3)
    }
    @IBOutlet var SubThumbnail_4: UIButton!
    @IBAction func SubThumbnailAction_4(_ sender: Any) {
        SetThumbnail(button: SubThumbnail_4)
    }
    @IBOutlet var NickName: UILabel!
    @IBAction func NickNameChangeAction(_ sender: Any) {
        // TODO : 닉네임 변경 팝업 추가
    }
    @IBOutlet var Age: UITextField!
    @IBOutlet var Gander: UILabel!
    @IBOutlet var Desc: UITextView!
    
    let ThumbnailPicker = UIImagePickerController()
    var placeholderLabel : UILabel!
    let AgePickerView = UIPickerView()
    
    var SelectSubThumbnail : UIButton? = nil
    
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
            
            let subThumbnailList = myData.GetThumbnailList()
            for i in 0..<subThumbnailList.count
            {
                if subThumbnailList[i] != "1"
                {
                    switch(i)
                    {
                    case 1:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_1, url:URL(string:subThumbnailList[i])!, circle: false)
                        break;
                    case 2:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_2, url:URL(string:subThumbnailList[i])!, circle: false)
                        break;
                    case 3:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_3, url:URL(string:subThumbnailList[i])!, circle: false)
                        break;
                    case 4:
                        CommonUIFunc.Instance.SetThumbnail(button: SubThumbnail_4, url:URL(string:subThumbnailList[i])!, circle: false)
                        break;
                    default:
                        break;
                    }
                }
            }
        }
    }
    
    public func SetThumbnail(button : UIButton)
    {
        self.SelectSubThumbnail = button;
        
        let thumbnailChange = {
            CommonUIFunc.Instance.OpenThumbnailPic(viewController: self, thumbnailPicker: self.ThumbnailPicker)
        }
        
        let thumbnailDelete = {
            if let thumbnail = self.SelectSubThumbnail
            {
                thumbnail.setBackgroundImage(UIImage.init(named: "etc_icon_picture"), for: .normal)
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
                // TODO : 이미지를 선택하면 바로 파이어 베이스에 올라가나??
                thumbnail.setBackgroundImage(image, for: .normal)
                print(info)
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
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_MYPROFILE_MEMO)
    }
}
