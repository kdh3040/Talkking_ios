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
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func fff(_ sender: Any) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
            
        }
        
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            
            self.openCamera()
            
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        picker.delegate = self
    }
    
    func openLibrary(){
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: false, completion: nil)
        
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            
            picker.sourceType = .camera
            
            present(picker, animated: false, completion: nil)
            
        }
            
        else{
            
            print("Camera not available")
            
        }
    }
}

extension UIViewController_InputPage : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            // 이미지 세팅
            //imageView.image = image
            
            print(info)
            
        }
        dismiss(animated: true, completion: nil)
        
    }
}
