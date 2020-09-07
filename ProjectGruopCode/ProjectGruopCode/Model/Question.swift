//
//  Question.swift
//  ProjectGruopCode
//
//  Created by Hoang Lam on 9/5/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import Foundation

struct Question : Decodable {
var id : Int
var question : String
var answer1 : String
 var answer2 : String
 var answer3 : String
 var answer4 : String
 var right : Int
  
init( id: Int, question : String, answer1 : String, answer2 : String, answer3 : String ,answer4 : String , right :Int ) {
    self.id = id
    self.question = question
    self .answer1 = answer1
    self .answer2 = answer2
    self .answer3 = answer3
    self .answer4 = answer4
    self .right = right
}

}

