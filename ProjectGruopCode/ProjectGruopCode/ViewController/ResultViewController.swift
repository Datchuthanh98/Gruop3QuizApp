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
    var id = ""
    var nameUser = ""
    var ref = Database.database().reference()
    var category = ""
    var isPassed = ""
    let date = Date()
    var calendar = Calendar.current

    
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
        if(score >= 5){
            gif.isHidden = false
            gif.loadGif(name: "ziazia")
            self.txtScore.text = "Passed : \(self.score) /10 "
            self.txtScore.textColor = UIColor.green
        }
        else {
            self.txtScore.text = "Failed : \(self.score) /10 "
            self.txtScore.textColor = UIColor.red
            gif.isHidden = true
        }
    }
    

  
    
    func setResult(){
        if(self.option == 1){
            self.id = UserDefaults.standard.string(forKey: "idFB") ?? ""
        } else {
            self.id = UserDefaults.standard.string(forKey: "idGG") ?? ""
        }
        self.nameUser = UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined"
        if(score < 5){
            isPassed = "FAIL"
        }else {
            isPassed = "PASS"
        }
    }
    
    func savetoServer(){
        setResult()
        var hour = calendar.component(.hour, from: date)
        var minute = calendar.component(.minute, from: date)

        
        
       let postHistory = [
        "id" : id,
        "userName" : nameUser,
        "score" : score ,
        "isPassed" : isPassed ,
        "time" : "\(hour)-\(minute)"
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
