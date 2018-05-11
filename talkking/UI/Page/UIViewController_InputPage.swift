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
        let alert =  UIAlertController(title: "프로필 사진", message: "선택해주세요", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) {
            (action) in self.openLibrary()
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) {
            (action) in self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
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
    
    
    let AgeData = ["20","21","22","23","24","25","26","27","28","29",
                   "30","31","32","33","34","35","36","37","38","39",
                   "40","41","42","43","44","45","46","47","48","49",
                   "50","51","52","53","54","55","56","57","58","59",
                   "60","61","62","63","64","65","66","67","68","69",
                   "70","71","72","73","74","75","76","77","78","79",
                   "80","81","82","83","84","85","86","87","88","89",
                   "90","91","92","93","94","95","96","97","98","99"]
    let GenderData = ["남자","여자"]
    
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

    func openLibrary()
    {
        ThumbnailPicker.sourceType = .photoLibrary
        present(ThumbnailPicker, animated: false, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            ThumbnailPicker.sourceType = .camera
            present(ThumbnailPicker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
    
    
    
    
}

extension UIViewController_InputPage : UIPickerViewDataSource, UIPickerViewDelegate
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

extension UIViewController_InputPage : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return AgeData.count
        } else {
            return GenderData.count
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return AgeData[row]
        } else {
            return GenderData[row]
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            Age.text = AgeData[row]
        } else {
            Gender.text = GenderData[row]
        }
    }
}

extension UIViewController_InputPage : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
 */
        let currentText = textField.text ?? ""
        return currentText.count <= 7
    }
}

