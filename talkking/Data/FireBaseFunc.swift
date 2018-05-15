//
//  FireBaseFunc.swift
//  talkking
//
//  Created by 도호소프트 on 2018. 4. 27..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SVProgressHUD
class FireBaseFunc
{
    static let Instance = FireBaseFunc()
    var ref : DatabaseReference!
    var CallbackFunc: ()
    var callbackExist : Bool = false
    var LoadDataCnt : Int = 0
    
    private init() {
         FirebaseApp.configure()
          ref = Database.database().reference()
    }
   
    public func SetCallFunc(callbackFunc : ())
    {
        CallbackFunc = callbackFunc
        callbackExist = true
    }
    
    public func CallBackFunc_LoadMyData(count : Int)
    {
        LoadDataCnt += count
        
        if LoadDataCnt == CommonData.LOAD_DATA_TYPE
        {
            CommonUIFunc.DismissLoading()
        }
        
    }
    
    
    public func LoadUserIndex(uuid : String)
    {
        
        
        ref.child("UserIdx").child(uuid).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            var tempData = snapshot.value as? String
            
           // tempData  = nil
            
            if let tempMyIdx = tempData {
                
                self.LoadMyData(index: tempMyIdx, complete: self.CallBackFunc_LoadMyData)
 
                self.LoadBoardDataList()
            
            }
            else
            {
                self.CalcUserIdx(uuid: uuid)
            }
            
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
    public func CalcUserIdx(uuid : String)
    {
        ref.child("UserCount").runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? Int {
                
                post += 1
                
                // Set value and report transaction success
                currentData.value = post
                self.ref.child("UserIdx").child(uuid).setValue(String(post))
                self.CreateUserData(userIdx: String(post))
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func CreateUserData(userIdx : String)
    {
     
    }
    
    public func LoadMyData(index : String, complete : @escaping ((_ count : Int)->())) //-> UserData?
    {
        
        ref.child("GenderList").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            var tempGender = snapshot.value as? String
            
            // tempData  = nil
            
            if let tempUserGender = tempGender {
                
                
                if tempUserGender == "남자"
                {
                    self.ref.child("Users").child("Man").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
                        
                        if let tempData = snapshot.value as? NSDictionary
                        {
                            let retValue : UserData = UserData.init(tempData: tempData)
                            
                            DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                         
                                DataMgr.Instance.MyData = MyUserData(index: Int(index)!)
                            
                                complete(CommonData.LOAD_DATA_SET)
                            
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[0], complete: self.CallBackFunc_LoadMyData)
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[1], complete: self.CallBackFunc_LoadMyData)
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[2], complete: self.CallBackFunc_LoadMyData)
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[3], complete: self.CallBackFunc_LoadMyData)
                            
                        }
                    }){ (error) in
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    self.ref.child("Users").child("Woman").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
                        
                        if let tempData = snapshot.value as? NSDictionary
                        {
                            let retValue : UserData = UserData.init(tempData: tempData)
                            
                            DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                            
                           
                                DataMgr.Instance.MyData = MyUserData(index: Int(index)!)
                            
                                complete(CommonData.LOAD_DATA_SET)
                            
                            
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[0], complete: self.CallBackFunc_LoadMyData)
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[1], complete: self.CallBackFunc_LoadMyData)
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[2], complete: self.CallBackFunc_LoadMyData)
                                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[3], complete: self.CallBackFunc_LoadMyData)
                            
                            
                        }
                    }){ (error) in
                        print(error.localizedDescription)
                    }
                }
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        //return nil
    }
    
    public func LoadUserData(index : String, complete : @escaping ((_ index : Int)->())) //-> UserData?
    {
        
        ref.child("GenderList").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            var tempGender = snapshot.value as? String
            
            // tempData  = nil
            
            if let tempUserGender = tempGender {
                
         
                    if tempUserGender == "남자"
                    {
                        self.ref.child("Users").child("Man").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
                            
                            if let tempData = snapshot.value as? NSDictionary
                            {
                                let retValue : UserData = UserData.init(tempData: tempData)
                                
                                DataMgr.Instance.SetCachingUserDataList(userData: retValue)                            
                                complete(Int(index)!)
                            }
                        }){ (error) in
                            print(error.localizedDescription)
                        }
                    }
                    else
                    {
                        self.ref.child("Users").child("Woman").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
                            
                            if let tempData = snapshot.value as? NSDictionary
                            {
                                let retValue : UserData = UserData.init(tempData: tempData)
                                
                                DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                               complete(Int(index)!)
                            }
                        }){ (error) in
                            print(error.localizedDescription)
                        }
                    }
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        //return nil
    }
     var i : Int = 0
    
    public func LoadSimpleUserData(index : String, complete : @escaping ((_ count : Int)->())) //-> UserData?
    {
       
        self.ref.child("SimpleData").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            if let tempData = snapshot.value as? NSDictionary
            {
                let retValue : UserData = UserData.init(tempData: tempData)
                
                DataMgr.Instance.SetCachingSimpleUserDataList(userData: retValue)
                self.i += CommonData.LOAD_DATA_SET;
                complete(self.i)
               
            }
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
    
    public func LoadUserDataList(sortRef : String, complete : @escaping ((_ count : Int)->())) //-> UserData?
    {
        
        if DataMgr.Instance.MyData!.Gender == GENDER_TYPE.MALE
        {
            ref.child("Users").child("Woman").queryOrdered(byChild: sortRef).queryLimited(toFirst: UInt(CommonData.LOAD_USERDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
                
                var viewIdx : Int = 0
                for childSnapshot in snapshot.children
                {
                    
                    let tempChildData = childSnapshot as! DataSnapshot
                    let tempData = tempChildData.value as? NSDictionary
                    let retValue : UserData = UserData.init(tempData: tempData!)
                    
                    DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                    
                    
                    if sortRef == CommonData.HOME_VIEW_REF[0]
                    {
                        DataMgr.Instance.SetUserDataList_RecvHeart(ViewIndex : viewIdx, userIndex: retValue.Index)
                        
                        if DataMgr.Instance.GetUserDataList_RecvHeart_Count() == CommonData.LOAD_USERDATA_COUNT
                        {
                            complete(CommonData.LOAD_DATA_SET)
                        }
                       
                    }
                    else if sortRef == CommonData.HOME_VIEW_REF[1]
                    {
                        DataMgr.Instance.SetUserDataList_FanCount(ViewIndex: viewIdx, userIndex: retValue.Index)
                        if DataMgr.Instance.GetUserDataList_FanCount_Count() == CommonData.LOAD_USERDATA_COUNT
                        {
                            complete(CommonData.LOAD_DATA_SET)
                        }
                    }
                    else if sortRef == CommonData.HOME_VIEW_REF[2]
                    {
                        DataMgr.Instance.SetUserDataList_Near(ViewIndex: viewIdx, userIndex: retValue.Index)
                        if DataMgr.Instance.GetUserDataList_Near_Count() == CommonData.LOAD_USERDATA_COUNT
                        {
                            complete(CommonData.LOAD_DATA_SET)
                        }
                    }
                    else if sortRef == CommonData.HOME_VIEW_REF[3]
                    {
                        DataMgr.Instance.SetUserDataList_New(ViewIndex: viewIdx, userIndex: retValue.Index)
                        if DataMgr.Instance.GetUserDataList_New_Count() == CommonData.LOAD_USERDATA_COUNT
                        {
                            complete(CommonData.LOAD_DATA_SET)
                        }
                    }
                    
                    viewIdx += 1
                }
                
                
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        else
        {
            ref.child("Users").child("Man").queryOrdered(byChild: sortRef).queryLimited(toFirst: UInt(CommonData.LOAD_USERDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
                
                var viewIdx : Int = 0
                for childSnapshot in snapshot.children
                {
                    
                    let tempChildData = childSnapshot as! DataSnapshot
                    let tempData = tempChildData.value as? NSDictionary
                    let retValue : UserData = UserData.init(tempData: tempData!)
                    
                    DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                    
                    if sortRef == CommonData.HOME_VIEW_REF[0]
                    {
                        DataMgr.Instance.SetUserDataList_RecvHeart(ViewIndex : viewIdx, userIndex: retValue.Index)
                    }
                    else if sortRef == CommonData.HOME_VIEW_REF[1]
                    {
                        DataMgr.Instance.SetUserDataList_FanCount(ViewIndex: viewIdx, userIndex: retValue.Index)
                    }
                    else if sortRef == CommonData.HOME_VIEW_REF[2]
                    {
                        DataMgr.Instance.SetUserDataList_Near(ViewIndex: viewIdx, userIndex: retValue.Index)
                    }
                    else if sortRef == CommonData.HOME_VIEW_REF[3]
                    {
                        DataMgr.Instance.SetUserDataList_New(ViewIndex: viewIdx, userIndex: retValue.Index)
                    }
                    
                    viewIdx += 1
                }
                
                
            }){ (error) in
                print(error.localizedDescription)
            }
        }
        
       
    
        //return nil
    }
    
    public func LoadBoardDataList() //-> UserData?
    {
        ref.child("Board").queryLimited(toFirst: UInt(CommonData.LOAD_BOARDDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                
                var tempChildData = childSnapshot as! DataSnapshot
                var tempData = tempChildData.value as? NSDictionary
                var retValue : BoardData = BoardData.init(tempData: tempData!)
                
                DataMgr.Instance.SetBoardData(boardData: retValue)
            }
            
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
}
