//
//  TeamDetailViewController.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class TeamDetailViewController: UIViewController {
    var team: Team?
    private var teamRuns: [Run] = []
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamWeekly: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Detail"
        if let team = team,
         let week = team.weekly {
            for day in week{
                if let run = day.run{
                    if run.status != "no run" {
                        teamRuns.append(run)
                        teamNameLabel.text = team.teamName
                        teamImageView.image = UIImage(named: team.teamName)
                    }
                }
            }
        }
        teamWeekly.reloadData()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let runDetailViewController = segue.destination as? RunDetailViewController,
           let cell = sender as? TeamDetailTableViewCell,
           let indexPath = teamWeekly.indexPath(for: cell){
            runDetailViewController.run = teamRuns[indexPath.row]
        }
    }

}
extension TeamDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return teamRuns.count //wrong
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailTableViewCell") as? TeamDetailTableViewCell else { return UITableViewCell() }
        
        let run = teamRuns[indexPath.row]
        cell.runStatusLabel.text = run.status
        if let time = run.hour,
           let day = run.dayName{
            let dayDetailed = "\(day) - \(time.prefix(time.count - 2)):\(time.suffix(2))"
            cell.dayLabel.text = dayDetailed
        }

        return cell
    }
   
    
}
