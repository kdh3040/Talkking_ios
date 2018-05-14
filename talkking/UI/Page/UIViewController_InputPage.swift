//
//  UIViewController_InputPage.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 7..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UIViewController_InputPage : UIViewController
{
    @IBAction func ThumbnailAction(_ sender: Any) {
        CommonUIFunc.Instance.OpenThumbnailPic(viewController: self, thumbnailPicker: ThumbnailPicker)
    }
    @IBOutlet var Thumbnail: UIButton!
    
    @IBOutlet var NIckName: UITextField!

    @IBOutlet var Age: UITextField!
    @IBOutlet var Gender: UITextField!
    @IBAction func InputProfileCheckAction_1(_ sender: Any) {
        if InputProfileCheckData_1 == true
        {
            InputProfileCheckData_1 = false
        }
        else
        {
            InputProfileCheckData_1 = true
        }
        

        if InputProfileCheckData_1 == true
        {
            InputProfileCheck_1.setImage(UIImage.init(named: "etc_check_full"), for: .normal)
        }
        else
        {
            InputProfileCheck_1.setImage(UIImage.init(named: "etc_check_empty"), for: .normal)
        }
    }
    @IBOutlet var InputProfileCheck_1: UIButton!
    @IBAction func InputProfileDescAction_1(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:1)
        self.present(page, animated: true)
    }
    
    @IBAction func InputProfileCheckAction_2(_ sender: Any) {
        if InputProfileCheckData_2 == true
        {
            InputProfileCheckData_2 = false
        }
        else
        {
            InputProfileCheckData_2 = true
        }
        
        if InputProfileCheckData_2 == true
        {
            InputProfileCheck_2.setImage(UIImage.init(named: "etc_check_full"), for: .normal)
        }
        else
        {
            InputProfileCheck_2.setImage(UIImage.init(named: "etc_check_empty"), for: .normal)
        }
    }
    @IBOutlet var InputProfileCheck_2: UIButton!
    @IBAction func InputProfileDescAction_2(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:2)
        self.present(page, animated: true)
    }
    
    @IBAction func InputProfileDescAction_3(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:3)
        self.present(page, animated: true)
    }
    @IBAction func CreateAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    let ThumbnailPicker = UIImagePickerController()
    let AgePickerView = UIPickerView()
    let GenderPickerView = UIPickerView()
    
    var InputProfileCheckData_1 : Bool = false
    var InputProfileCheckData_2 : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ThumbnailPicker.delegate = self
 
        Age.inputView = AgePickerView
        Gender.inputView = GenderPickerView
        AgePickerView.dataSource = self
        AgePickerView.delegate = self
        AgePickerView.tag = 1
        
        GenderPickerView.dataSource = self
        GenderPickerView.delegate = self
        GenderPickerView.tag = 2
        
        NIckName.delegate = self;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIViewController_InputPage : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            Thumbnail.setImage(image, for: .normal)
            print(info)
            
        }
        dismiss(animated: true, completion: nil)
    }
}

extension UIViewController_InputPage : UIPickerViewDataSource, UIPickerViewDelegate
{
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return CommonData.AGE_DATA.count
        } else {
            return CommonData.GENDER_DATA.count
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return CommonData.AGE_DATA[row]  + "세"
        } else {
            return CommonData.GENDER_DATA[row]
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            Age.text = CommonData.AGE_DATA[row]  + "세"
        } else {
            Gender.text = CommonData.GENDER_DATA[row]
        }
    }
}

extension UIViewController_InputPage : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        return CommonUIFunc.Instance.IsInputStringLimit(string: currentText, limit: CommonData.STR_LIMIT_INPUT_NICKNAME)
    }
}

