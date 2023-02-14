//
//  RegisterViewController.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import UIKit
import FirebaseDatabase
class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    private var email = ""
    private var password = ""
    private var username = ""
    private var city: City = City(cityID: 1, cityName: "ADANA")
    private var team = "Rundamental"
    private var message = ""
    private var nextUserID = 99
    private var database = Database.database().reference()
    var userArray: [User]?
    var cityArray: [City]?
    var teamArray: [Team]?

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    @IBOutlet weak var teamPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamPicker.delegate = self
        cityPickerView.delegate = self
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround() 
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let  cityArray = cityArray,
           let teamArray = teamArray{
            if pickerView.tag == 1 {
                return cityArray.count
            } else {
                return teamArray.count
            }
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let  cityArray = cityArray,
           let teamArray = teamArray{
            if pickerView.tag == 1 {
                print("ow")
                return "\(cityArray[row].cityName)"
            } else {
                print("yey")
                return "\(teamArray[row].teamName)"
            }
        }
        return ""
    }
    @IBAction func registerButtonAction(_ sender: UIButton) {
        Task { @MainActor in
            if let tempeMail = emailField.text{
                self.email = tempeMail
            }
            if let tempUserName = userNameField.text{
                self.username = tempUserName
            }
            if let tempPassword = passwordField.text{
                self.password = tempPassword
            }
            register()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func register() {
        if(!checkCreditentials()) {
            return
        }
        if let userArray = userArray{
            self.nextUserID = userArray.count
            for user in userArray{
                if(user.username == self.username) {
                    return
                }
                if(user.email == self.email) {
                    return
                }
            }
            database.child("users").child("\(self.nextUserID)").setValue(["username":self.username,"password":self.password,"email":self.email, "city":["cityID":self.city.cityID,"cityName":self.city.cityName],"team":team])
            
            self.userArray?.append((User(username: self.username, email: self.email)))
            nextUserID += 1
            changeRoot()
            
        }
        
    }
    func changeRoot(){
        UserDefaults.standard.set(true, forKey: "ISLOGGEDIN")
        UserDefaults.standard.set(self.username, forKey: "username")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "rootNavCont") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            if let city = cityArray?[row]{
                self.city = city
            }
        } else {
            
            if let team = teamArray?[row].teamName{
                self.team = team
            }
        }
     }
    private func checkCreditentials() -> Bool{
        if self.username == ""{
            self.message = "Username cannot be empty"
            return false
        }
        if self.password == ""{
            self.message = "Password cannot be empty"
            return false
        }
        if self.email == ""{
            self.message = "Email cannot be empty"
            return false
        }
        return true
    }
}
