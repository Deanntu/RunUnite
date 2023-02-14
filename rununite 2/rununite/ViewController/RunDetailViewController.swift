//
//  RunDetailViewController.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class RunDetailViewController: UIViewController {
    @IBOutlet weak var runTypeLabel: UILabel!
    @IBOutlet weak var runDayLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var isBeginnerFriendlyLabel: UILabel!
    var run: Run?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Run Detail"
        if let status = run?.status,
           let dayID = run?.dayID,
           let monthID = run?.monthID,
           let yearID = run?.yearID,
           let beginnerFriendly = run?.beginnerFriendly,
           let place = run?.place,
           let team = run?.team,
           let distance = run?.distance{
            
            teamNameLabel.text = "Team Name: \(team)"
            runDayLabel.text = "Date: \(dayID)/\(monthID)/\(yearID)"
            runTypeLabel.text = "Run Type: \(status)"
            distanceLabel.text = "Distance: \(distance)"
            placeLabel.text = "Place: \(place)"
            isBeginnerFriendlyLabel.text = "Beginner Friendly: \(beginnerFriendly.uppercased(with: Locale(identifier: "tr_TR")))"
        }
        
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
