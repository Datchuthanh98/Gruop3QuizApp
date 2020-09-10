//
//  SettingViewController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/9/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {
    
    @IBOutlet weak var btnProfileOutlet: UIButton!
    @IBOutlet weak var btnSettingTestOutlet: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnProfileOutlet.layer.cornerRadius = btnProfileOutlet.bounds.height / 4
        btnSettingTestOutlet.layer.cornerRadius = btnSettingTestOutlet.bounds.height / 4
        btnProfileOutlet.layer.borderWidth = 1
        btnProfileOutlet.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        btnSettingTestOutlet.layer.borderWidth = 1
        btnSettingTestOutlet.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    }
    
    func setShadow(){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        print("vao setting r")
    }
    

    @IBAction func lcikProfile(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabarProfile") 
        //           vc.score = self.score
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickConfigExam(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "configExamScreen") as! ConfigexamViewController
                                         //           vc.score = self.score
                                         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
