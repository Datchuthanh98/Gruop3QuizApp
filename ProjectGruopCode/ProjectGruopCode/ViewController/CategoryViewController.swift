//
//  CategoryViewController.swift
//  ProjectGruopCode
//
//  Created by V000232 on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import Firebase


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var listCategory = [""]
    var choose = -1
    var ref = Database.database().reference()
    let dataTable = "1HxVup2Hiua1mhNIMNujHJhj4zatLWKs_WXQH5qiypZA"
    var refreshControl = UIRefreshControl()


    
    
    @IBOutlet weak var tblCategory: UITableView!
    
    //MARK: Load Subview
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCategory.delegate = self
        tblCategory.dataSource = self
//          lblUserName.text = "\(UserDefaults.standard.string(forKey: "nameUserSession") ?? "Underfined")"
        let nibName = UINib(nibName: "CategoryCustomCell", bundle: nil)
        tblCategory.register(nibName, forCellReuseIdentifier: "CategoryCell")
        GetListCategory()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblCategory.addSubview(refreshControl) // not
        

    }
    
    @objc func refresh(_ sender: AnyObject) {
        GetListCategory()
        refreshControl.endRefreshing()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCustomCell
        cell.delegate = self
        cell.lblCategory.text = listCategory[indexPath.row]
        cell.nameCategory = listCategory[indexPath.row]
        
        cell.imgCategory.layer.cornerRadius = 10
        cell.btnTryTest.layer.cornerRadius = 10
        cell.btnListQues.layer.cornerRadius = 10
        
        cell.viewContent.layer.cornerRadius = 10
        cell.viewContent.layer.borderWidth = 1
        cell.viewContent.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        cell.btnTryTest.layer.cornerRadius = 10
        cell.btnTryTest.layer.borderWidth = 2
        cell.btnTryTest.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        cell.btnListQues.layer.cornerRadius = 10
        cell.btnListQues.layer.borderWidth = 2
        cell.btnListQues.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        choose = indexPath.row
    }
    
  
    
    
    func showDialogPick(){
         let myAlert = UIAlertController(title: "You have not choose item!", message: "Please pick any item to continue", preferredStyle: .alert)
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
//        vc.category = listCategory[choose]
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
    
//    func custom() {
//        btnHistory.layer.cornerRadius = btnHistory.bounds.height / 2
//
//    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "option")
        UserDefaults.standard.removeObject(forKey: "nameUserSession")
          UserDefaults.standard.removeObject(forKey: "idGG")
        UserDefaults.standard.removeObject(forKey: "idFB")
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
        self.navigationController?.pushViewController(vc, animated: true)
    }
        

}



extension CategoryViewController : SmartDelegate {
    func didTapButton(with: String, nameCate: String) {
   print(with)
         if with == "view" {
          
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listQuestionScreen") as? QuestionViewController
            vc?.category = nameCate
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
  
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "examScreen") as? ViewController
            vc?.category = nameCate
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }

}
