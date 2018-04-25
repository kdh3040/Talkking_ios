//
//  CommonUIFunc.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 4. 25..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation

class CommonUIFunc{
    static let Instance = CommonUIFunc()
    
    public func GetGradeImgName(grade:Int) -> String{
        if(CommonData.RANK_ICON.count <= grade)
        {
            return ""
        }
        
        
        return CommonData.RANK_ICON[grade - 1]
    }
}
