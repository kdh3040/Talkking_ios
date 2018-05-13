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
        self.dismiss(animated: true)
    }
    @IBAction func Save(_ sender: Any) {
    }
    @IBAction func MainThumbnailAction(_ sender: Any) {
    }
    @IBAction func SubThumbnailAction_1(_ sender: Any) {
    }
    @IBAction func SubThumbnailAction_2(_ sender: Any) {
    }
    @IBAction func SubThumbnailAction_3(_ sender: Any) {
    }
    @IBAction func SubThumbnailAction_4(_ sender: Any) {
    }
    @IBOutlet var NickName: UILabel!
    @IBAction func NickNameChangeAction(_ sender: Any) {
    }
    @IBOutlet var Age: UITextField!
    @IBOutlet var Gander: UILabel!
    @IBOutlet var Desc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
