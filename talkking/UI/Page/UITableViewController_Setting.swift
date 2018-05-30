//
//  UITableViewController_Setting.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 15..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit

class UITableViewController_Setting : UITableViewController
{
    @IBOutlet var AlarmSound: UISwitch!
    @IBAction func AlarmSoundAction(_ sender: Any) {
        // TODO 도형 : 알람 설정
        if AlarmSound.isOn
        {
             DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Sound = true
            print("알람소리 ON")
        }
        else
        {
            DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Sound = false
            print("알람소리 OFF")
        }
    }
    @IBOutlet var AlarmVibration: UISwitch!
    @IBAction func AlarmVibrationAction(_ sender: Any) {
        // TODO 도형 : 알람 진동 설정
        if AlarmVibration.isOn
        {
             DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Vibe = true
            print("알람진동 ON")
        }
        else
        {
             DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Vibe = false
            print("알람진동 OFF")
        }
    }
    @IBOutlet var AlarmPopup: UISwitch!
    @IBAction func AlarmPopupAction(_ sender: Any) {
        // TODO 도형 : 알람 팝업 설정
        if AlarmPopup.isOn
        {
            DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Popup = true
            print("알람팝업 ON")
        }
        else
        {
            DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Popup = false
            print("알람팝업 OFF")
        }
    }
    @IBOutlet var MsgRefusal: UISwitch!
    @IBAction func MsgRefusalAction(_ sender: Any) {
        // TODO 도형 : 쪽지 수신거부 설정
        if MsgRefusal.isOn
        {
            DataMgr.Instance.MyData!.CahingSettingDataList[0].RecvMode_Msg = 0
            print("쪽지수신거부 ON")
        }
        else
        {
            DataMgr.Instance.MyData!.CahingSettingDataList[0].RecvMode_Msg = 1
            print("쪽지수신거부 OFF")
        }
    }
    @IBAction func BlockListAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "BLOCK_LIST_PAGE") as! UIViewController_BlockListPage
        self.present(page, animated: true)
    }
    @IBAction func ShareAction(_ sender: Any) {
        // TODO 도형 : 공유기능
        
    }
    @IBAction func CoinChargeAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "CHARGE_PAGE") as! UIViewController_ChargePage
        self.present(page, animated: true)
    }
    @IBAction func ProvisionAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:1)
        self.present(page, animated: true)
    }
    @IBAction func HelpAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "PROVISION_PAGE") as! UIViewController_ProvisionPage
        page.SetProvisionType(type:4)
        self.present(page, animated: true)
    }
    @IBAction func DeleteUserAction(_ sender: Any) {
        // TODO 도형 : 계정 삭제 기능
        
        FireBaseFunc.Instance.RemoveUserData()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.keyWindow?.rootViewController = vc
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO 도형 : 세팅 데이터 필요
        AlarmSound.isOn = DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Sound
        AlarmVibration.isOn = DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Vibe
        AlarmPopup.isOn = DataMgr.Instance.MyData!.CahingSettingDataList[0].AlarmMode_Popup
        if DataMgr.Instance.MyData!.CahingSettingDataList[0].RecvMode_Msg == 0
        {
             MsgRefusal.isOn = true
        }
        else
        {
             MsgRefusal.isOn = false
        }
    }
}
