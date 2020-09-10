//
//  ResultViewController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class ResultViewController: UIViewController {
    
    var score = 0
    let option = UserDefaults.standard.integer(forKey: "option")
    var avatar = "\(UserDefaults.standard.string(forKey: "avatar") ?? "Underfined")"
    var id = ""
    var nameUser = ""
    var ref = Database.database().reference()
    var category = ""
    var isPassed = ""
    let date = Date()
    var calendar = Calendar.current
    var timeComplete = 0
    var numberQuestion = 0
    
    @IBOutlet weak var gif: UIImageView!
    @IBOutlet weak var btnBack: UIButton!

    @IBOutlet weak var txtScore: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        custom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        lblNamePlayer.text = "Name Player : \(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
     
        savetoServer()
        // Do any additional setup after loading the view.
     
            gif.isHidden = false
            gif.loadGif(name: "ziazia")
            self.txtScore.text = "You finish exam with score : \(self.score)/\(self.numberQuestion) in \(timeComplete) second"
            self.txtScore.textColor = UIColor.green
       
    }
    

  
    
    func setResult(){
        if(self.option == 1){
            self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
        } else {
            self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
        }
        self.nameUser = UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined"
    
    }
    
    func savetoServer(){
        setResult()
        var hour = calendar.component(.hour, from: date)
        var minute = calendar.component(.minute, from: date)
           var day = calendar.component(.day, from: date)
           var month = calendar.component(.month, from: date)
           var yeah = calendar.component(.year, from: date)
        

        
        
       let postHistory = [
        "id" : id,
        "userName" : nameUser,
        "avatar" : avatar,
        "numberQuestion" : numberQuestion,
        "score" : score ,
        "timeHistory" : "\(day)/\(month)/\(yeah)  \(hour):\(minute)" ,
        "timeComplete" : timeComplete
        ] as [String : Any]
        
        ref.child("history").child(category).childByAutoId().setValue(postHistory,withCompletionBlock: { error , ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }else{
                //handle
            }
        } )
    }
    
    @IBAction func btnBacktoHome(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabBarhome") 
                     //           vc.score = self.score
                     self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func custom() {
        btnBack.layer.cornerRadius = btnBack.bounds.height / 2
        txtScore.layer.cornerRadius = txtScore.bounds.height / 3
        txtScore.layer.masksToBounds = true
    }
}
