//
//  Category.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/3/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import Foundation

struct Category : Decodable {
    var name : String
}


    


struct HistoryExam : Decodable {
    var name: String
    var category: String
    var score: Int
    var result: String
    
}
