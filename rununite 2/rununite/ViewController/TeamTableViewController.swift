//
//  TeamTableViewController.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import Foundation
import UIKit

class TeamTableViewController: UIViewController {
    private var teamArray: [Team] = []
    private let dataSource = SharedDataSource()
    
    @IBOutlet weak var teamTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        teamArray = dataSource.getTeamArray()
        self.title = "Teams"
        // Do any additional setup after loadingthe view.
        //print(teamArray![0])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let teamDetailViewController = segue.destination as? TeamDetailViewController,
           let cell = sender as? TeamTableViewCell,
           let indexPath = teamTable.indexPath(for: cell){
            teamDetailViewController.team = teamArray[indexPath.row]
        }
    }
}

extension TeamTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as? TeamTableViewCell else {
            return UITableViewCell()
        }
        let team = teamArray[indexPath.row]
        cell.teamNameLabel.text = team.teamName.uppercased(with: Locale(identifier: "tr_TR"))
        
        return cell
    }
    
}
extension TeamTableViewController: SharedDataDelegate {
   /* func teamListLoaded() {
        self.teamArray = dataSource.getTeamArray()
        print("patatesleri severim")
        self.teamTable.reloadData()
    }*/
}

