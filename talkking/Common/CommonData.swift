//
//  CommonData.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

struct CommonData {
    
    public static let RANK_ICON = ["icon_rank_bronze", "icon_rank_silver", "icon_rank_gold", "icon_rank_diamond", "icon_rank_vip", "icon_rank_vvip"]
    public static let ITEM_ICON = ["icon_item_opal", "icon_item_pearl", "icon_item_amethyst", "icon_item_sapphire", "icon_item_emerald", "icon_item_ruby","icon_item_diamond"]
    public static let FAN_RANK_ICON_BIG = ["fan_rank_big_1", "fan_rank_big_2", "fan_rank_big_3"]
    public static let FAN_RANK_ICON = ["fan_rank_1", "fan_rank_2", "fan_rank_3"]
    public static let MAIN_RANK_ICON = ["etc_main_rank_1", "etc_main_rank_2", "etc_main_rank_3"]
    
    public static let HOME_VIEW_REF = ["RecvGold", "FanCount", "Dist", "Date"]
    public static let LOAD_USERDATA_COUNT = 60
    
    public static let LOAD_BOARDDATA_COUNT = 10
    
    public static let STR_LIMIT_INPUT_NICKNAME = 8
    public static let STR_LIMIT_MYPROFILE_MEMO = 100
    public static let STR_LIMIT_SEND_MSG = 30
    public static let STR_LIMIT_BOARD_MSG = 100
    public static let STR_LIMIT_HEART_SEND_MSG = 50
    
    public static let GACHA_COST = 7
    public static let NICKNAME_CHANGE_COST = 500
    public static let MSG_COST = 8
    
    public static let BOARD_WIRTE_LIMIT_TIME_MIN = 600
    public static let MILLISECOND = 1000
    
    public static let USER_CHECK_NO = 0
    public static let USER_CHECK_OK = 1
    
    public static let AGE_DATA =
                  ["20","21","22","23","24","25","26","27","28","29",
                   "30","31","32","33","34","35","36","37","38","39",
                   "40","41","42","43","44","45","46","47","48","49",
                   "50","51","52","53","54","55","56","57","58","59",
                   "60","61","62","63","64","65","66","67","68","69",
                   "70","71","72","73","74","75","76","77","78","79",
                   "80","81","82","83","84","85","86","87","88","89",
                   "90","91","92","93","94","95","96","97","98","99"]
    public static let GENDER_DATA = ["남자","여자"]

    public static let LOAD_DATA_SET = 1
    public static let LOAD_DATA_TYPE = 10
    
    public static let REPORT_BOARD_DELETE = 10
    
    public static let REF_LAT = 38.910042
    public static let REF_LON = 125.848755
    
    public static let DEF_LAT = 37.475610
    public static let DEF_LON = 127.007094
    
    public static let RADIUS = 6378140.0
    
    public static var JewelDataList : [JewelData] = [JewelData]()
    
    public struct JewelData {
        var Name : String = ""
        var Image : String = ""
        var InfoImage : String = ""
        var Percent : Float = 0
        var Have : Int = 0
        let SellCost : Int = 4
        var Index : Int = -1
    }
    


}
