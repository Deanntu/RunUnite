//
//  MainViewController.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import Foundation
import UIKit
import FirebaseDatabase

class MainViewController: UIViewController {
    
    // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
    @IBOutlet weak var closestRunTableView: UITableView!
    
    
    private var database = Database.database().reference()
    private var userArray: [User] = []
    private var teamArray: [Team] = []
    private var cityArray: [City] = []
    private var closestRunArray: [Run] = []
    private var user: User = User(username: "none", email: "none")
    
    private let dataSource = SharedDataSource()
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var cityNumber: UILabel!
    
    // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize()
        self.title = "Main Menu"
        dataSource.delegate = self
        dataSource.initialize()
        loadTable()
        self.closestRunTableView.rowHeight = 120.0
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileDetailViewController = segue.destination as? ProfileDetailViewController{
            profileDetailViewController.user = self.user
        }
        if let runDetailViewController = segue.destination as? RunDetailViewController,
           let cell = sender as? ClosestRunTableViewCell,
           let indexPath = closestRunTableView.indexPath(for: cell){
            runDetailViewController.run = closestRunArray[indexPath.row]
        }
    }

    func loadTable(){
        self.closestRunArray = []
        self.teamArray = dataSource.getTeamArray()
        for i in self.teamArray {
            if let week = i.weekly {
                for day in week {
                    if let run = day.run{
                        if run.status != "no run"{
                            self.closestRunArray.append(run)
                        }
                    }
                }
            }
        }
        closestRunArray = sortClosestRuns(runs: closestRunArray)
        self.closestRunTableView.reloadData()
    }
    func sortClosestRuns(runs: [Run]) -> [Run] {
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        //let dateList = dateString.split(separator: "/")
        let dayName = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: currentDate) - 1]
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        var tempRunArray: [Run] = []
        let daysOfWeek = ["Monday": 10000, "Tuesday": 20000, "Wednesday": 30000, "Thursday": 40000, "Friday": 50000, "Saturday": 60000, "Sunday": 70000]
        var runDictionary =  [Int: Int]()
        let currentScore = (daysOfWeek[dayName] ?? 0) + (hour*100 + minute)
        if runs.count > 0{
            
            for i in 0...runs.count-1 {
                let score = (daysOfWeek[runs[i].dayName ?? "Monday"] ?? 0) + (Int(runs[i].hour ?? "900") ?? 0)
                if score > currentScore {
                    runDictionary.updateValue(score, forKey: i)
                }
            }
            let sortedByValueRunDictionary = runDictionary.sorted { $0.1 < $1.1 }
            
            if sortedByValueRunDictionary.count >= 1 {
                for i in 0...sortedByValueRunDictionary.count-1 {
                    
                    tempRunArray.append(runs[sortedByValueRunDictionary[i].key])
                    
                }
            }
            
        }
        return tempRunArray
        
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return closestRunArray.count //wrong
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClosestRunTableViewCell") as? ClosestRunTableViewCell else { return UITableViewCell() }
        
        let run = closestRunArray[indexPath.row]
        cell.teamImage.image = UIImage(named: run.team ?? "none")
        cell.teamNameLabel.text = "Team: \(run.team ?? "none")"
        cell.placeLabel.text = "Place: \(run.place ?? "none")"
        cell.distanceLabel.text = "Distance: \(run.distance ?? 0)km"
 
        if let time = run.hour,
           let day = run.dayName{
            let hour = "\(day) - \(time.prefix(time.count - 2)):\(time.suffix(2))"
            cell.timeLabel.text = hour
   
        }
        return cell
    }
   
    
}
extension MainViewController: SharedDataDelegate {
    func teamListLoaded() {
        self.closestRunArray = []
        self.teamArray = dataSource.getTeamArray()
        for i in self.teamArray {
            if let week = i.weekly {
                for day in week {
                    if let run = day.run{
                        if run.status != "no run"{
                            self.closestRunArray.append(run)
                        }
                    }
                }
            }
        }
        closestRunArray = sortClosestRuns(runs: closestRunArray)
        self.closestRunTableView.reloadData()
    }
    func userListLoaded() {
        self.userArray = dataSource.getUserArray()
        
        for user in userArray{
            
            if user.username == (UserDefaults.standard.string(forKey: "username")){
                self.user = user
                cityNumber.text = "\(user.city?.cityName ?? "None") - \(user.city?.cityID ?? 0)"
            }
        }
    }
}
