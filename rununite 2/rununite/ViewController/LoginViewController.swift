//
//  LoginViewController.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import UIKit
import FirebaseDatabase

class LoginViewController: UIViewController {
    private var email = ""
    private var password = ""
    private var username = ""
    private var message = ""
    private var session = "23423"
    private var database = Database.database().reference()
    var userArray: [User]?
    var teamArray: [Team]?
    var cityArray: [City]?
    
    
    @IBOutlet weak var eMailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        Task { @MainActor in
            if let tempeMail = eMailField.text {
                email = tempeMail
            }
            if let tempPassword = passwordField.text {
                password = tempPassword
            }
            if(login()){
                UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let viewController = storyboard.instantiateViewController(withIdentifier: "rootNavCont") as! UITabBarController
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
            print(message)
        }
    }
    
    
    func login() -> Bool{
        if let userArray = userArray {
            for user in userArray{
                if(user.email == self.email && user.password == self.password){
                    self.session = user.username
                    self.message = "Logged in succesfully"
                    UserDefaults.standard.set(self.session, forKey: "username")
                    print(session)
                    return true
                }
                else if (user.email == self.email && user.password != self.password){
                    self.message = "Wrong password"
                }
                else if (user.email != self.email){
                    self.message = "User not found"
                }
                
            }
        }
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
