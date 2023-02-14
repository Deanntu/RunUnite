//
//  SetTeamViewController.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class SetTeamViewController: UIViewController {
    var user: User?
    @IBOutlet weak var teamTableView: UITableView!
    private let dataSource = SharedDataSource()
    private var teamArray: [Team] = []
    var delegate: SetTeamViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Set Team"
        dataSource.delegate = self
        teamTableView.allowsSelection = true
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
extension SetTeamViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        user?.team = teamArray[indexPath.row].teamName
    
        delegate?.setTeamViewControllerResponse(user: user!)
        
        self.dismiss(animated: true,completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamSelectTableViewCell") as? TeamSelectTableViewCell else {
            return UITableViewCell()
        }
        let team = teamArray[indexPath.row]
        cell.teamNameLabel.text = team.teamName.uppercased(with: Locale(identifier: "tr_TR"))
        
        return cell
    }
    
}
protocol SetTeamViewControllerDelegate{
    func setTeamViewControllerResponse(user: User)
}

extension SetTeamViewController: SharedDataDelegate {
    func userListLoaded() {
        
    }
    
    func teamListLoaded() {
        teamArray = dataSource.getTeamArray()
        teamTableView.reloadData()
    }
    
    func cityListLoaded() {
        
    }
}
