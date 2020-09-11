//
//  ItemHistory.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import Foundation


struct History {
    var id : String
    var userName : String
    var score : Int
    var timeComplete : Int
    var timeHistory : String
    var numberQuestion : Int
    var avatar : String
        
    init( id: String, userName : String, avatar : String, score : Int,numberQuestion : Int , timeComplete : Int  ,timeHistory :String) {
        self.id = id
        self.userName = userName
        self .score = score
        self .timeComplete  = timeComplete
        self .timeHistory = timeHistory
        self.numberQuestion = numberQuestion
        self.avatar = avatar
    }
    

}

