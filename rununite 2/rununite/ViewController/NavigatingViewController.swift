//
//  ViewController.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import UIKit
import FirebaseDatabase

class NavigatingViewController: UIViewController {

    private var database = Database.database().reference()
    private var userArray: [User] = []
    private var teamArray: [Team] = []
    private var cityArray: [City] = []
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let dataSource = SharedDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
      /*  if(UserDefaults.standard.bool(forKey: "ISLOGGEDIN")){
            loginButton.setTitle("RESUME", for: .normal)
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tryAutoLogin()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        //tryAutoLogin()
    }
    func tryAutoLogin(){
        if(UserDefaults.standard.bool(forKey: "ISLOGGEDIN")){
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: "rootNavCont") as! UITabBarController
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let registerViewController = segue.destination as? RegisterViewController{
            registerViewController.userArray = userArray
            registerViewController.cityArray = cityArray
            registerViewController.teamArray = teamArray
        }
        if let loginViewController = segue.destination as? LoginViewController{
            loginViewController.userArray = userArray
            loginViewController.cityArray = cityArray
            loginViewController.teamArray = teamArray
        }
        
      /* if let teamTableViewController = segue.destination as? TeamTableViewController{
            teamTableViewController.teamList = teamDataSource.getTeams()
           print(teamDataSource.getTeams()?.count)
        }*/
    }

}
extension NavigatingViewController: SharedDataDelegate {
    func teamListLoaded() {
       self.teamArray = dataSource.getTeamArray()
    }
    func cityListLoaded() {
        self.cityArray = dataSource.getCityArray()
    }
    func userListLoaded() {
        self.userArray = dataSource.getUserArray()
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
