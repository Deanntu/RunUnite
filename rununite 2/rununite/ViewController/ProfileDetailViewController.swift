//
//  ProfileDetailViewController.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var profilePageImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        usernameLabel.text = "Username: \(user?.username ?? "none")"
        teamNameLabel.text = "Team: \(user?.team ?? "none")"
        cityNameLabel.text = "City: \(user?.city?.cityName ?? "none")"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
