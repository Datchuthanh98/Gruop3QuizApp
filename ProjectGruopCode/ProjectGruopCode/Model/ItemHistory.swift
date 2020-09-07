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
    var isPassed : String
     
        
    init( id: String, userName : String, score : Int, isPassed : String  ) {
        self.id = id
        self.userName = userName
        self .score = score
        self .isPassed = isPassed
    }
    

}

