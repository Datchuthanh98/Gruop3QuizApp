//
//  LoginController.swift
//  ProjectGruopCode
//
//  Created by Chu Thanh Dat on 9/4/20.
//  Copyright © 2020 Chu Thanh Dat. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class LoginController: UIViewController {

    @IBOutlet weak var btnLoginFacebook: UIButton!
    @IBOutlet weak var btnLoginGoogle: UIButton!
    
    
    
    var isLogined = UserDefaults.standard.integer(forKey: "option") ?? 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        custom()
        autoLogin()
        // gán signin vào controller này
        GIDSignIn.sharedInstance().presentingViewController = self
        
    }
    
    func autoLogin(){
        print(isLogined)
        if isLogined != 0 {
            print("vao day r")
            nextToCategoryScreen()
        }
    }
    
    @IBAction func btnFacebookTapped(_ sender: Any) {
     
        
        fbLogin()
    }
    
    @IBAction func btbGoogleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    // đăng xuất gg
    @IBAction func didTapSignOut(_ sender: UIButton) {
      GIDSignIn.sharedInstance().signOut()
        print("out google")
    }
    
    // hàm login facebook
    func fbLogin() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [ "public_profile", "email"], viewController: self, completion: { loginResult in
            switch loginResult {
                
            case .success(granted: _, declined: _, token: _):
                self.getFBUserData()
                
            case .cancelled:
                print("User Canceled login process")
                
            case .failed(let error):
                print(error)
            }
        })
    }
    
    // hàm lấy data fb
    func getFBUserData() {
        if ((AccessToken.current) != nil) {
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                
                // nếu không xảy ra lỗi
                if (error == nil){
                    
                    let dict = result as! [String : AnyObject]
                    
                    let picutreDic = dict as NSDictionary
                    
                    
                    let nameOfUser = picutreDic.object(forKey: "name") as! String
                      let idOfUser = picutreDic.object(forKey: "id") as! String
               
                    
                    UserDefaults.standard.set(idOfUser, forKey: "idFB")
                    UserDefaults.standard.set(nameOfUser, forKey: "nameUserSession")
                    UserDefaults.standard.set(1, forKey: "option")
                    
                    self.nextToCategoryScreen()
                    var tmpEmailAdd = ""
                    
                    if let emailAddress = picutreDic.object(forKey: "email") {
                        tmpEmailAdd = emailAddress as! String
                        print(tmpEmailAdd)
                    }
                    else {
                        var usrName = nameOfUser
                        usrName = usrName.replacingOccurrences(of: " ", with: "")
                        tmpEmailAdd = usrName+"@facebook.com"
                    }
                    
                }
                
             
            })
        }
    }
    
    func logoutGG() {
        // add signout Button
        let gSignOutGoogle = UIButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
        gSignOutGoogle.backgroundColor = UIColor.red
        gSignOutGoogle.setTitle("Sign Out Google", for: .normal)
        gSignOutGoogle.center = view.center
        gSignOutGoogle.center.y = view.center.y + 300
        gSignOutGoogle.addTarget(self, action: #selector(self.didTapSignOut(_:)), for: .touchUpInside)
        view.addSubview(gSignOutGoogle)
    }
    

    func custom() {
        // custom btn login facebook
        btnLoginFacebook.backgroundColor = UIColor.init(red: 51.0/255, green: 66.0/255, blue: 145.0/255, alpha: 1)
        btnLoginFacebook.layer.cornerRadius = btnLoginFacebook.bounds.height / 6
        btnLoginFacebook.layer.borderWidth = 3
        btnLoginFacebook.layer.borderColor = UIColor.white.cgColor
        // custom btn login google
        btnLoginGoogle.backgroundColor = UIColor.init(red: 232.0/255, green: 42.0/255, blue: 57.0/255, alpha: 1)
        btnLoginGoogle.layer.cornerRadius = btnLoginGoogle.bounds.height / 6
        btnLoginGoogle.layer.borderWidth = 3
        btnLoginGoogle.layer.borderColor = UIColor.white.cgColor
    }
    
    
      func nextToCategoryScreen(){
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "categoryScreen") as! CategoryViewController
                   self.navigationController?.pushViewController(vc, animated: true)
        }
     
    
    

}

//MARK: aaa
extension LoginController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let currentUser = GIDSignIn.sharedInstance()?.currentUser
        
        let userIDGoogle = currentUser?.userID
        let nameIDGoogle = currentUser?.profile.name
        UserDefaults.standard.set(userIDGoogle, forKey: "idGG")
        UserDefaults.standard.set(nameIDGoogle, forKey: "nameUserSession")
        UserDefaults.standard.set(2, forKey: "option")
         nextToCategoryScreen()
    }
}
