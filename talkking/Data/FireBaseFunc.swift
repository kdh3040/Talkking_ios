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
    public var CallBackCount : Int = 0
    
    
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
            CommonUIFunc.Instance.ShowMainPage()
        }
        
    }
    
    
    public func LoadUserIndex(uuid : String)
    {
        
        
        ref.child("UserIdx").child(uuid).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            var tempData = snapshot.value as? String
            
           // tempData  = nil
            
            if let tempMyIdx = tempData {
                
                self.LoadMyData(index: tempMyIdx, complete: self.CallBackFunc_LoadMyData)
                self.LoadNotification()
                
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
                
                self.CreateUserData(uuid : uuid, userIdx: String(post))
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func CreateUserData(uuid : String, userIdx : String)
    {
        CommonUIFunc.DismissLoading()
        CommonUIFunc.Instance.ShowInputPage(uuid : uuid, index : userIdx)
    }
    
    public func LoadMyData(index : String, complete : @escaping ((_ count : Int)->())) //-> UserData?
    {
        
        ref.child("GenderList").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            let tempGender = snapshot.value as? String
            
            // tempData  = nil
            
            if let tempUserGender = tempGender {
                
                self.ref.child("Users").child(CommonFunc.Instance.ConvertGenderString(gender: tempUserGender)).child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
                    
                    if let tempData = snapshot.value as? NSDictionary
                    {
                        let indexInt = Int(index)!
                        let retValue : UserData = UserData.init(tempData: tempData)
                        
                        DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                        
                        DataMgr.Instance.MyData = MyUserData(index: indexInt)
                        
                        self.LoadChatList(complete: self.CallBackFunc_LoadMyData)
                        
                        self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[0], complete: self.CallBackFunc_LoadMyData)
                        self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[1], complete: self.CallBackFunc_LoadMyData)
                        self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[2], complete: self.CallBackFunc_LoadMyData)
                        self.LoadUserDataList(sortRef: CommonData.HOME_VIEW_REF[3], complete: self.CallBackFunc_LoadMyData)
                        
                        // TODO 도형 : 이함수가 왜 2번 들어오는지 모르겠음(환웅)
                        self.LoadBlockDataList(index: indexInt, complete: self.CallBackFunc_LoadMyData)
                        self.LoadBlockedDataList(index: indexInt, complete: self.CallBackFunc_LoadMyData)
                        self.LoadBoardDataList(complete: self.CallBackFunc_LoadMyData)
                        self.LoadMyBoardData(complete: self.CallBackFunc_LoadMyData)
                        self.LoadRecvHeartData(complete: self.CallBackFunc_LoadMyData)
                    }
                }){ (error) in
                    print(error.localizedDescription)
                }
            }
        }){ (error) in
            print(error.localizedDescription)
        }
        //return nil
    }
    
    public func LoadUserData(index : String, complete : @escaping (_ index : Int, _ view : UIViewController? )->(), view : UIViewController? = nil) //-> UserData?
    {
        
        ref.child("GenderList").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            let tempGender = snapshot.value as? String
            
            // tempData  = nil
            
            if let tempUserGender = tempGender {
                self.ref.child("Users").child(CommonFunc.Instance.ConvertGenderString(gender: tempUserGender)).child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
                    
                    if let tempData = snapshot.value as? NSDictionary
                    {
                        let retValue : UserData = UserData.init(tempData: tempData)
                        
                        DataMgr.Instance.SetCachingUserDataList(userData: retValue)
                        complete(Int(index)!, view)
                    }
                }){ (error) in
                    print(error.localizedDescription)
                }
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        //return nil
    }
 
    
    public func LoadSimpleUserData(index : String, complete : @escaping ((_ count : Int)->())) //-> UserData?
    {
       
        self.ref.child("SimpleData").child(index).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            if let tempData = snapshot.value as? NSDictionary
            {
                let retValue : UserData = UserData.init(tempData: tempData)
                
                DataMgr.Instance.SetCachingSimpleUserDataList(userData: retValue)
                self.CallBackCount += CommonData.LOAD_DATA_SET
                complete(self.CallBackCount)
               
            }
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
    
    public func LoadUserDataList(sortRef : String, complete : @escaping ((_ count : Int)->())) //-> UserData?
    {
        if let myData = DataMgr.Instance.MyData
        {
            ref.child("Users").child(CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)).queryOrdered(byChild: sortRef).queryLimited(toFirst: UInt(CommonData.LOAD_USERDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
                
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
    }
    
    public func LoadBoardDataList(complete : @escaping (_ count : Int)->()) //-> UserData?
    {
        ref.child("Board").queryLimited(toFirst: UInt(CommonData.LOAD_BOARDDATA_COUNT)).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                
                let tempChildData = childSnapshot as! DataSnapshot
                let tempData = tempChildData.value as? NSDictionary
                let retValue : BoardData = BoardData.init(tempData: tempData!)
                
                DataMgr.Instance.SetBoardData(boardData: retValue)
            }
            complete(CommonData.LOAD_DATA_SET)
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
    
    public func LoadBoardDataList(top : Bool, complete : @escaping ()->Void)
    {
        CommonUIFunc.ShowLoading()
        
        var currIndex : Int = 0
        var nextIndex : Int = 0
        
        if top == true
        {
            currIndex = DataMgr.Instance.BoardTopIndex - 10
            nextIndex = DataMgr.Instance.BoardTopIndex
        }
        else
        {
            currIndex = DataMgr.Instance.BoardBottomIndex
            nextIndex = DataMgr.Instance.BoardBottomIndex + 10
        }
        
        ref.child("Board").queryOrdered(byChild: "BoardIdx").queryStarting(atValue: currIndex).queryEnding(atValue: nextIndex).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                
                let tempChildData = childSnapshot as! DataSnapshot
                let tempData = tempChildData.value as? NSDictionary
                let retValue : BoardData = BoardData.init(tempData: tempData!)
                
                DataMgr.Instance.SetBoardData(boardData: retValue)
            }
            CommonUIFunc.DismissLoading()
            complete()
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
    
    public func LoadBlockDataList(index:Int, complete : @escaping (_ count : Int)->())
    {
        ref.child("BlockList").child(String(index)).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                let tempChildData = childSnapshot as! DataSnapshot
                let tempData = tempChildData.value as? NSDictionary
                let retValue : BlockData = BlockData.init(tempData: tempData!)
                
                DataMgr.Instance.MyData!.SetBlockData(retValue)
            }
            
            complete(CommonData.LOAD_DATA_SET)
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
    public func LoadBlockedDataList(index:Int, complete : @escaping (_ count : Int)->())
    {
        ref.child("BlockedList").child(String(index)).observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                let tempChildData = childSnapshot as! DataSnapshot
                let tempData = tempChildData.value as? NSDictionary
                let retValue : BlockData = BlockData.init(tempData: tempData!)
                
                DataMgr.Instance.MyData!.SetBlockedData(retValue)
            }
            complete(CommonData.LOAD_DATA_SET)
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
    public func LoadNotification()
    {
        ref.child("CommonValue").child("Notification").observeSingleEvent(of: .value, with: { ( snapshot) in
            
            for childSnapshot in snapshot.children
            {
                
                var tempChildData = childSnapshot as! DataSnapshot
                var tempData = tempChildData.value as? NSDictionary
                var retValue : NotificationData = NotificationData.init(tempData: tempData!)
                
                DataMgr.Instance.SetNotificationData(index: Int(tempChildData.key)!, notiData: retValue)
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
        //return nil
    }
    
    public func SetFavorList(userData : UserData)
    {
        if let myData = DataMgr.Instance.MyData
        {
            self.ref.child("Users").child(CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)).child(String(DataMgr.Instance.MyData!.Index)).child("CardList").child(String(userData.Index)).setValue(String(userData.Index))
        }
    }
    
    public func DelFavorList(userData : UserData)
    {
        if let myData = DataMgr.Instance.MyData
        {
            self.ref.child("Users").child(CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)).child(String(DataMgr.Instance.MyData!.Index)).child("CardList").child(String(userData.Index)).removeValue()
        }
    }
    
    public func LoadChatList(complete : @escaping ((_ count : Int)->()))
    {
        if let myData = DataMgr.Instance.MyData
        {
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)
            
            ref.child("Users").child(gender).child(String(DataMgr.Instance.MyData!.Index)).child("SendList").observeSingleEvent(of: .value, with: { ( snapshot) in
                
                for childSnapshot in snapshot.children
                {
                    let tempChildData = childSnapshot as! DataSnapshot
                    let tempChat = tempChildData.value as? NSDictionary
                    
                    if tempChat != nil
                    {
                        let tempChatData : ChatData = ChatData()
                        
                        tempChatData.Idx = Int(tempChat!["Idx"] as! String)!
                        tempChatData.ChatRoomName = tempChat!["ChatRoomName"] as! String
                        tempChatData.Check = tempChat!["Check"] as! Int
                        tempChatData.Date = tempChat!["Date"] as! Double
                        tempChatData.Msg = tempChat!["Msg"] as! String
                        tempChatData.WriterIdx = tempChat!["WriterIdx"] as! String
                        
                        DataMgr.Instance.MyData!.ChatDataList.append(tempChatData)
                    }
                }
                
                complete(CommonData.LOAD_DATA_SET)
                
            }){ (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    public func SetChatList(userData : UserData, msg : String)
    {
        var strChatRoomName : String = ""
        strChatRoomName = String(DataMgr.Instance.MyData!.Index) + "_" + String(userData.Index)
      
        let writeDate = Date()
        
        let gender : String = CommonFunc.Instance.ConvertGenderString(gender: userData.Gender)
        
        self.ref.child("Users").child(gender).child(String(userData.Index)).child("SendList").child(strChatRoomName).child("ChatRoomName").setValue(strChatRoomName)
        self.ref.child("Users").child(gender).child(String(userData.Index)).child("SendList").child(strChatRoomName).child("Check").setValue(0)
        self.ref.child("Users").child(gender).child(String(userData.Index)).child("SendList").child(strChatRoomName).child("Date").setValue(writeDate.timeIntervalSince1970 * Double(CommonData.MILLISECOND))
        self.ref.child("Users").child(gender).child(String(userData.Index)).child("SendList").child(strChatRoomName).child("Idx").setValue(String(DataMgr.Instance.MyData!.Index))
        self.ref.child("Users").child(gender).child(String(userData.Index)).child("SendList").child(strChatRoomName).child("Msg").setValue(msg)
        self.ref.child("Users").child(gender).child(String(userData.Index)).child("SendList").child(strChatRoomName).child("WriterIdx").setValue(String(DataMgr.Instance.MyData!.Index))
    }
    
    public func SetMyCoin()
    {
        if let myData = DataMgr.Instance.MyData
        {
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)
            self.ref.child("Users").child(gender).child(String(myData.Index)).child("Honey").setValue(myData.Coin)
        }
    }
    
    
    public func SetFanList(userData : UserData, Heart : Int, view : UIViewController)
    {
        var addFan : Bool = true
        var saveHeart : Int = Heart
        let gender : String = CommonFunc.Instance.ConvertGenderString(gender: userData.Gender)
        
        if let myData = DataMgr.Instance.MyData
        {
            if userData.FanDataList.count > 0
            {
                for i in 0..<userData.FanDataList.count
                {
                    if userData.FanDataList[i].Idx == myData.Index
                    {
                        addFan = false
                        saveHeart = userData.FanDataList[i].RecvHeart
                        userData.FanDataList[i].RecvHeart += Heart
                        break
                    }
                }
            }
            
            if addFan
            {
                userData.AddFanList(idx: myData.Index, recvGold: Heart)
            }
            
            userData.SortFanList()
            CommonUIFunc.Instance.CheckFanRank(userData: userData, view : view)
            
            self.ref.child("Users").child(gender).child(String(userData.Index)).child("FanList").child(String(myData.Index)).child("Check").setValue(CommonData.USER_CHECK_NO)
            self.ref.child("Users").child(gender).child(String(userData.Index)).child("FanList").child(String(myData.Index)).child("Idx").setValue(String(myData.Index))
            self.ref.child("Users").child(gender).child(String(userData.Index)).child("FanList").child(String(myData.Index))
            .child("RecvGold").setValue(saveHeart)
        }
    }
    
    public func RemoveBlockDataList(index:Int)
    {

        if let myData = DataMgr.Instance.MyData
        {
            ref.child("BlockList").child(String(myData.Index)).child(String(index)).removeValue()
            
            ref.child("BlockedList").child(String(index)).child(String(myData.Index)).removeValue()
        }
    }
    
    public func UpdateMyCoin(complete : @escaping ()-> Void)
    {
        CommonUIFunc.ShowLoading()
        if let myData = DataMgr.Instance.MyData
        {
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)
            self.ref.child("Users").child(gender).child(String(myData.Index)).child("Honey").observeSingleEvent(of: .value, with: { ( snapshot) in
                
                CommonUIFunc.DismissLoading()
                if let tempData = snapshot.value as? Int
                {
                    myData.Coin = tempData
                    complete()
                }
            }){ (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    public func SetMyPoint()
    {
        if let myData = DataMgr.Instance.MyData
        {
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)
            self.ref.child("Users").child(gender).child(String(myData.Index)).child("Point").setValue(myData.Point)
        }
    }
    
    public func WriteBoard(msg:String, complete: @escaping () -> Void)
    {
        CommonUIFunc.ShowLoading()
        ref.child("BoardIdx").runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? Int {
                
                post -= 1
                currentData.value = post
                
                let currentTime = CommonFunc.Instance.GetCurrentTime()
                
                
                if let myData = DataMgr.Instance.MyData
                {
                    self.ref.child("Board").child(String(post)).child("BoardIdx").setValue(post)
                    self.ref.child("Board").child(String(post)).child("Date").setValue(currentTime)
                    self.ref.child("Board").child(String(post)).child("Idx").setValue(String(myData.Index))
                    self.ref.child("Board").child(String(post)).child("Msg").setValue(msg)
                    
                    if myData.Gender == GENDER_TYPE.FEMALE
                    {
                        self.ref.child("Users").child("Woman").child(String(DataMgr.Instance.MyData!.Index)).child("LastBoardWriteTime").setValue(currentTime)
                    }
                    else
                    {
                        self.ref.child("Users").child("Man").child(String(DataMgr.Instance.MyData!.Index)).child("LastBoardWriteTime").setValue(currentTime)
                    }
                    
                    myData.BoardWriteTime = currentTime
                    let boardData : BoardData = BoardData()
                    boardData.BoardIndex = post
                    boardData.BoardText = msg
                    boardData.UserIndex = myData.Index
                    boardData.WriteTime = currentTime
                    DataMgr.Instance.SetBoardData(boardData: boardData)
                    DataMgr.Instance.SetMyBoardData(boardData: boardData)
                    
                    complete()
                    CommonUIFunc.DismissLoading()
                }
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func UpdateJewelData()
    {
        if let myData = DataMgr.Instance.MyData
        {
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)
            for i in 0..<myData.Item.count
            {
                self.ref.child("Users").child(gender).child(String(DataMgr.Instance.MyData!.Index)).child(String.init(format:"Item_%d",i + 1)).setValue(myData.Item[i])
            }
        }
    }
    
    public func LoadMyBoardData(complete : @escaping (_ count : Int)->())
    {
        if let myData = DataMgr.Instance.MyData
        {
            ref.child("Board").queryOrdered(byChild: "Idx").queryEqual(toValue: String(myData.Index)).observeSingleEvent(of: .value, with: { ( snapshot) in
            
                for childSnapshot in snapshot.children
                {
                    
                    let tempChildData = childSnapshot as! DataSnapshot
                    let tempData = tempChildData.value as? NSDictionary
                    let retValue : BoardData = BoardData.init(tempData: tempData!)
                    
                    DataMgr.Instance.SetMyBoardData(boardData: retValue)
                }
                
                complete(CommonData.LOAD_DATA_SET)
            }){ (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    public func RemoveMyBoardData(boardIdx : Int)
    {
        DataMgr.Instance.RemoveMyBoardData(index: boardIdx)
        ref.child("Board").child(String(boardIdx)).removeValue()
    }
    
    public func RemoveBoardData(boardIdx : Int)
    {
        DataMgr.Instance.RemoveBoardData(index: boardIdx)
        ref.child("Board").child(String(boardIdx)).removeValue()
    }
    
    public func ReportBoardData(boardIdx : Int)
    {
        DataMgr.Instance.RemoveBoardData(index: boardIdx)
        if let myData = DataMgr.Instance.MyData
        {
            ref.child("Board").child(String(boardIdx)).child("ReportList").child(String(myData.Index)).child("Date").setValue(CommonUIFunc.Instance.ConvertTimeString(time: Date().timeIntervalSince1970, format: "yyyyMMddHHmm"))
            ref.child("Board").child(String(boardIdx)).child("ReportList").child(String(myData.Index)).child("Idx").setValue(String(myData.Index))
        }
    }
    
    public func LoadRecvHeartData(complete : @escaping (_ count : Int)->())
    {
        if let myData = DataMgr.Instance.MyData
        {
            self.ref.child("GiftHoneyList").child(String(myData.Index)).observeSingleEvent(of: .value, with: { ( snapshot) in
                
                for childSnapshot in snapshot.children
                {
                    let tempChildData = childSnapshot as! DataSnapshot
                    let tempData = tempChildData.value as? NSDictionary
                    let retValue : RecvHeartData = RecvHeartData.init(tempData: tempData!)
                    
                    myData.SetRecvHeartData(retValue)
                }
                complete(CommonData.LOAD_DATA_SET)
            }){ (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    public func UploadImgFromUrl(index : String, image : UIImage, complete : @escaping (_ count : String)->())
    {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let ImagePath = storageRef.child("Images").child(index)
  
        let uploadImg = UIImagePNGRepresentation(image)
        
        let uploadTask = ImagePath.putData(uploadImg!, metadata: nil){ (metadata, error) in
            
            guard let metadata = metadata else{
                return
            }
            let downLoad = metadata.path
            complete(downLoad!)
        }
    }
    
    public func SaveUserIndex(index : String, uid : String)
    {
        self.ref.child("UserIdx").child(uid).setValue(index)
    }
    
    public func SaveGenderList(index : String, Gender : String )
    {
        self.ref.child("GenderList").child(index).setValue(Gender)
    }
    
    public func SaveFirstData(index : String, Gender : String, TumbUrl : String, ImgUrl : String , NickName : String, Age : String
        , Lon : Double, Lat : Double, Dist : Double, CreateDate : Double)
    {

        let gender : String = CommonFunc.Instance.ConvertGenderString(gender: Gender)
        
        //self.ref.child("Users").child(tempGender).child(String(index)).child("Token").setValue(myData.Token)
            
        self.ref.child("Users").child(gender).child(index).child("Idx").setValue(String(index))
            
        self.ref.child("Users").child(gender).child(index).child("Img").setValue(TumbUrl)
        self.ref.child("Users").child(gender).child(index).child("ImgGroup0").setValue(ImgUrl)
        self.ref.child("Users").child(gender).child(index).child("ImgGroup1").setValue("1")
        self.ref.child("Users").child(gender).child(index).child("ImgGroup2").setValue("1")
        self.ref.child("Users").child(gender).child(index).child("ImgGroup3").setValue("1")
        self.ref.child("Users").child(gender).child(index).child("ImgCount").setValue(1)
        
        self.ref.child("Users").child(gender).child(index).child("NickName").setValue(NickName)
        self.ref.child("Users").child(gender).child(index).child("Gender").setValue(Gender)
        self.ref.child("Users").child(gender).child(index).child("Age").setValue(Age)
            
        self.ref.child("Users").child(gender).child(index).child("Lon").setValue(Lon)
        self.ref.child("Users").child(gender).child(index).child("Lat").setValue(Lat)
        self.ref.child("Users").child(gender).child(index).child("Dist").setValue(Dist)
        
        self.ref.child("Users").child(gender).child(index).child("SendCount").setValue(0)
        self.ref.child("Users").child(gender).child(index).child("RecvGold").setValue(0)
        
        self.ref.child("Users").child(gender).child(index).child("Date").setValue(CreateDate)
        self.ref.child("Users").child(gender).child(index).child("Memo").setValue("")
            
        self.ref.child("Users").child(gender).child(index).child("FanCount").setValue(0)
        self.ref.child("Users").child(gender).child(index).child("Point").setValue(0)
        self.ref.child("Users").child(gender).child(index).child("Grade").setValue(0)
        self.ref.child("Users").child(gender).child(index).child("BestItem").setValue(0)
        self.ref.child("Users").child(gender).child(index).child("Honey").setValue(0)
        self.ref.child("Users").child(gender).child(index).child("NickChangeCnt").setValue(0)
        
    }
    
    
    public func SaveSimpleData(index : Int)
    {
        if let myData = DataMgr.Instance.MyData
        {
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)
            
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Token").setValue(myData.Token)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Idx").setValue(String(myData.Index))
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Img").setValue(myData.ThumbnailList[0])
            
            self.ref.child("SimpleData").child(gender).child(String(index)).child("NickName").setValue(myData.Name)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Gender").setValue(myData.Gender)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Age").setValue(String(myData.Age))
            
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Lon").setValue(myData.Lon)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Lat").setValue(myData.Lat)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Dist").setValue(myData.Distance)
            
            self.ref.child("SimpleData").child(gender).child(String(index)).child("SendCount").setValue(0)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("RecvGold").setValue(myData.RecvHeart)
            
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Date").setValue(myData.CreateDate)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Memo").setValue(myData.Memo)
            
            self.ref.child("SimpleData").child(gender).child(String(index)).child("FanCount").setValue(myData.FanCount)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Point").setValue(myData.Point)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Grade").setValue(myData.Grade)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("BestItem").setValue(myData.BestItem)
            self.ref.child("SimpleData").child(gender).child(String(index)).child("Honey").setValue(myData.Coin)
        }
    }
    
    
    public func SaveData(index : Int)
    {
        
        if let myData = DataMgr.Instance.MyData
        {
            SaveSimpleData(index: myData.Index)
            let gender : String = CommonFunc.Instance.ConvertGenderString(gender: myData.Gender)

            self.ref.child("Users").child(gender).child(String(index)).child("Token").setValue(myData.Token)
    
            self.ref.child("Users").child(gender).child(String(index)).child("Idx").setValue(String(myData.Index))
            
            self.ref.child("Users").child(gender).child(String(index)).child("Img").setValue(myData.ThumbnailList[0])
            self.ref.child("Users").child(gender).child(String(index)).child("ImgGroup0").setValue(myData.ThumbnailList[1])
            self.ref.child("Users").child(gender).child(String(index)).child("ImgGroup1").setValue(myData.ThumbnailList[2])
            self.ref.child("Users").child(gender).child(String(index)).child("ImgGroup2").setValue(myData.ThumbnailList[3])
            self.ref.child("Users").child(gender).child(String(index)).child("ImgGroup3").setValue(myData.ThumbnailList[4])
            self.ref.child("Users").child(gender).child(String(index)).child("ImgCount").setValue(myData.ImgCount)
            
            self.ref.child("Users").child(gender).child(String(index)).child("NickName").setValue(myData.Name)
            self.ref.child("Users").child(gender).child(String(index)).child("Gender").setValue(myData.Gender)
            self.ref.child("Users").child(gender).child(String(index)).child("Age").setValue(String(myData.Age))
            
            self.ref.child("Users").child(gender).child(String(index)).child("Lon").setValue(myData.Lon)
            self.ref.child("Users").child(gender).child(String(index)).child("Lat").setValue(myData.Lat)
            self.ref.child("Users").child(gender).child(String(index)).child("Dist").setValue(myData.Distance)
            
            self.ref.child("Users").child(gender).child(String(index)).child("SendCount").setValue(0)
            self.ref.child("Users").child(gender).child(String(index)).child("RecvGold").setValue(myData.RecvHeart)
            
            self.ref.child("Users").child(gender).child(String(index)).child("Date").setValue(myData.CreateDate)
            self.ref.child("Users").child(gender).child(String(index)).child("Memo").setValue(myData.Memo)
            
            self.ref.child("Users").child(gender).child(String(index)).child("FanCount").setValue(myData.FanCount)
            self.ref.child("Users").child(gender).child(String(index)).child("Point").setValue(myData.Point)
            self.ref.child("Users").child(gender).child(String(index)).child("Grade").setValue(myData.Grade)
            self.ref.child("Users").child(gender).child(String(index)).child("BestItem").setValue(myData.BestItem)
            self.ref.child("Users").child(gender).child(String(index)).child("Honey").setValue(myData.Coin)
            self.ref.child("Users").child(gender).child(String(index)).child("NickChangeCnt").setValue(myData.NickCheckCnt)
        }
    }
    
    public func RemoveRecvHeartData()
    {
        // TODO 도형 : 받은 하트 제거하는 기능 추가
        
        
    }
    
    public func RemoveAllRecvHeartData()
    {
        if let myData = DataMgr.Instance.MyData
        {
            self.ref.child("GiftHoneyList").child(String(myData.Index)).removeValue()
        }
    }
}
