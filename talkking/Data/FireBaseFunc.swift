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

class FireBaseFunc
{
    static let Instance = FireBaseFunc()
    var ref : DatabaseReference!
    
    private init() {
         FirebaseApp.configure()
          ref = Database.database().reference()
    }
   
    
    public func LoadUserIndex(uuid : String)
    {
        ref.child("UserIdx").child(uuid).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            var tempData = snapshot.value as? String
            
           // tempData  = nil
            
            if let tempMyIdx = tempData {
                self.LoadUserData(index: tempMyIdx, Mydata: true)
                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[0])
                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[1])
                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[2])
                self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[3])
                
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
    
    public func LoadUserData(index : String, Mydata : Bool) //-> UserData?
    {
        ref.child("User").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            let tempData = snapshot.value as? NSDictionary
            let retValue : UserData = UserData.init(tempData: tempData!)
            
             DataMgr.Instance.SetCahingUserDataList(userData: retValue)
            
            if Mydata
            {
                DataMgr.Instance.MyData = MyUserData(index: Int(index)!)
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
    
    
    public func LoadUserDataList(sortRef : String) //-> UserData?
    {
        ref.child("User").queryOrdered(byChild: sortRef).queryLimited(toFirst: UInt(CommonData.LOAD_USERDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
    
                for childSnapshot in snapshot.children
                {
                    
                    let tempChildData = childSnapshot as! DataSnapshot
                    let tempData = tempChildData.value as? NSDictionary
                    let retValue : UserData = UserData.init(tempData: tempData!)
                    
                    DataMgr.Instance.SetCahingUserDataList(userData: retValue)
                }
           
                
            }){ (error) in
            print(error.localizedDescription)
            }
    
        //return nil
    }
    
    public func LoadBoardDataList() //-> UserData?
    {
        ref.child("Board").queryLimited(toFirst: UInt(CommonData.LOAD_BOARDDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                
                let tempChildData = childSnapshot as! DataSnapshot
                let tempData = tempChildData.value as? NSDictionary
                let retValue : BoardData = BoardData.init(tempData: tempData!)
                
                DataMgr.Instance.SetBoardData(boardData: retValue)
            }
            
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
}
