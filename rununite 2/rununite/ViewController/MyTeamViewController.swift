//
//  MyTeamViewController.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import Foundation
import UIKit

class MyTeamViewController: UIViewController {
    private let dataSource = SharedDataSource()
    private var teamRuns: [Run] = []
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var myTeamImage: UIImageView!
    @IBOutlet weak var myTeamWeekly: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Team"
        dataSource.delegate = self
        dataSource.initialize()
        
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        viewDidLoad()
        if let userName = UserDefaults.standard.string(forKey: "username") {
            let user = dataSource.getMe(userName:  userName)
            let myTeamName = dataSource.getMyTeam(teamName: user.team ?? "none")
            myTeamImage.image = UIImage(named: myTeamName.teamName)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let runDetailViewController = segue.destination as? RunDetailViewController,
           let cell = sender as? MyTeamTableViewCell,
           let indexPath = myTeamWeekly.indexPath(for: cell){
            runDetailViewController.run = teamRuns[indexPath.row]
        }
    }
    
}
extension MyTeamViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return teamRuns.count //wrong
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTeamTableViewCell") as? MyTeamTableViewCell else { return UITableViewCell() }
        
        let run = teamRuns[indexPath.row]
        cell.runStatusLabel.text = run.status
        if let time = run.hour,
           let day = run.dayName{
            let dayDetailed = "\(day) - \(time.prefix(time.count - 2)):\(time.suffix(2))"
            cell.dayNameLabel.text = dayDetailed
   
        }

        return cell
    }
   
    
}
extension MyTeamViewController: SharedDataDelegate {
    func userListLoaded() {
        if let userName = UserDefaults.standard.string(forKey: "username") {
            teamRuns = []
            let user = dataSource.getMe(userName:  userName)
            print(user)
            let userTeam = dataSource.getMyTeam(teamName: user.team ?? "none")
            teamName.text = userTeam.teamName
            if let week = userTeam.weekly {
                for day in week{
                    if let run = day.run{
                        if run.status != "no run" {
                            teamRuns.append(run)
                        }
                    }
                }
            }
            myTeamWeekly.reloadData()
        }
    }
}
