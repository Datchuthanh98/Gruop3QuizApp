//
//  CategoryViewController.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listCategory = [""]
    var choose = -1
    var ref = Database.database().reference()
    let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"
    
    @IBOutlet weak var lblUserName: UILabel!
    
    
    @IBOutlet weak var tblCategory: UITableView!
    @IBOutlet weak var btnStartExam: UIButton!
    @IBOutlet weak var btnSeeListQuestion: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        custom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCategory.delegate = self
        tblCategory.dataSource = self
          lblUserName.text = "Name Player : \(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
        let nibName = UINib(nibName: "CategoryCustomCell", bundle: nil)
        tblCategory.register(nibName, forCellReuseIdentifier: "CategoryCell")
        GetListCategory()

    }
    

    @IBAction func clickStartExam(_ sender: Any) {
        if choose == -1 {
            showDialogPick()
        }else{
          nextoExamScreen()
        }
    }
    
    
    //MARK: xem danh sach
    @IBAction func clickSeeListQuestion(_ sender: Any) {
        if choose == -1 {
            showDialogPick()
        }else{
           nextoListQuestionScreen()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCustomCell
        cell.txtCategory.text = listCategory[indexPath.row]
        cell.txtCategory.layer.cornerRadius = cell.txtCategory.bounds.height / 2
        cell.txtCategory.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        choose = indexPath.row
    }
    
    
    func showDialogPick(){
         let myAlert = UIAlertController(title: "you have not choose item", message: "please pick any item to continue", preferredStyle: .alert)
                   let actionOnOk = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                     UIAlertAction in
                   //add your code here to execute while clicking ok button
                   }
                   myAlert.addAction(actionOnOk)
                   self.present(myAlert, animated: true, completion: nil)    }
    
    
    func nextoListQuestionScreen(){
        
     
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "listQuestionScreen") as! QuestionViewController
        vc.category = listCategory[choose]
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func nextoExamScreen(){
        
          
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "examScreen") as! ViewController
        vc.category = listCategory[choose]
                  self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func GetListCategory(){
        self.listCategory.removeAll()
        ref.child(dataTable).observe(.value, with: {
            snapshot in
            for category in snapshot.children {
                self.listCategory.append((category as AnyObject).key)
            }
            
            self.tblCategory.reloadData()
//            print(groupNames)
        })
    }
  
    @IBAction func clickHistoryExam(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "historyScreen") as! HistoryViewController

                                     self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func custom() {
        btnHistory.layer.cornerRadius = btnHistory.bounds.height / 2
        btnSeeListQuestion.layer.cornerRadius = btnSeeListQuestion.bounds.height / 2
        btnStartExam.layer.cornerRadius = btnStartExam.bounds.height / 2
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.removeObject(forKey: "option")
        UserDefaults.standard.removeObject(forKey: "nameUserSession")
          UserDefaults.standard.removeObject(forKey: "idGG")
        UserDefaults.standard.removeObject(forKey: "idFB")    }
        
}
