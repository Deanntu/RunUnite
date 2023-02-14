//
//  SettingsViewController.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit
import FirebaseDatabase
class SettingsViewController: UIViewController, SetCityViewControllerDelegate, SetTeamViewControllerDelegate {
    private var database = Database.database().reference()
    @IBOutlet weak var passwordField1: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    private var cityArray: [City] = []
    @IBOutlet weak var cityName: UIButton!
    @IBOutlet weak var teamName: UIButton!
    private let dataSource = SharedDataSource()
    private var message = ""
    var user:User?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.hideKeyboardWhenTappedAround()
        dataSource.delegate = self

        if let userName = UserDefaults.standard.string(forKey: "username") {
            user = dataSource.getMe(userName:  userName)
            cityName.setTitle(user?.city?.cityName, for: .normal)
            teamName.setTitle(user?.team, for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    func setCityViewControllerResponse(user: User){
        self.user = user
 
        cityName.setTitle(self.user?.city?.cityName, for: .normal)
    }
    func setTeamViewControllerResponse(user: User){
        self.user = user

        teamName.setTitle(self.user?.team, for: .normal)
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "ISLOGGEDIN")
        UserDefaults.standard.set("", forKey: "username")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "loginPageNav") as! UINavigationController
        self.view.window?.rootViewController = viewController
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateUser()
    }
    func updateUser(){
        var password = ""
        if let password1 = passwordField1.text,
           let password2 = passwordField2.text,
           let user = user{
            if(password1 == "" && password2 == ""){
                password = user.password!
            }
            else if(password1 != password2){
                message = "New passwords must be equal!"
                return
            }
            else if(password1 == "" || password2 == ""){
                message = "Password fields cannot be empty!"
                return
            } else {
                password = password1
            }
            
            database.child("users").observeSingleEvent(of: .value, with: {snapshot in
                if let data = snapshot.value as? NSArray{
                    for i in 0...data.count-1{
                        let row = snapshot.childSnapshot(forPath: String(i))
                        if let tempUserName = row.childSnapshot(forPath: "username").value{
                            if (tempUserName as? String == self.user?.username){
                                if let tempEmail = row.childSnapshot(forPath: "email").value{
                                    self.user?.password = password
                                    self.dataSource.setMe(userInput: self.user!)
                                    let post = ["username":tempUserName,"password":password,"email":tempEmail,"team":user.team,"city":["cityID":user.city?.cityID,"cityName":user.city?.cityName]]
                                    let childUpdates = ["/users/\(i)":post]
                                    self.database.updateChildValues(childUpdates)
                                    
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let citySetViewController = segue.destination as? SetCityViewController{
             citySetViewController.user = self.user
             citySetViewController.delegate = self
         }
         if let teamSetViewController = segue.destination as? SetTeamViewController{
             teamSetViewController.user = self.user
             teamSetViewController.delegate = self
         }
     }
    
}
extension SettingsViewController: SharedDataDelegate {
    func teamListLoaded() {
        
    }
    
    
    func userListLoaded() {
        
    }
}



