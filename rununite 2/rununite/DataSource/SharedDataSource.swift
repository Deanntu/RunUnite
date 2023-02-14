//
//  SharedDataSource.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import Foundation
import FirebaseDatabase
class SharedDataSource{
    private var database = Database.database().reference()
    private var userArray: [User] = []
    private var teamArray: [Team] = []
    private var cityArray: [City] = []
    private var closestRunArray: [Run] = []
    var delegate: SharedDataDelegate?
    
    init()  {
        initialize()
    }
    func getTeamArray() -> [Team]{
        return teamArray
    }
    func getCityArray() -> [City]{
        return cityArray
    }
    func getUserArray() -> [User]{
        return userArray
    }
    func setMe(userInput: User){
        for i in 0...userArray.count-1{
            if userInput.username == userArray[i].username{
                userArray[i] = userInput
            }
        }
    }
    func getMe(userName: String) -> User {
        
        for user in userArray{
            if userName == user.username{
                
                return user
            }
        }
        return User(username: "none", email: "none")
    }
    func getMyTeam(teamName: String) -> Team {
        for team in teamArray{
            if teamName == team.teamName{
                return team
            }
        }
        return Team(teamName: "none")
    }
    func initialize() {
        database.child("teams").observeSingleEvent(of: .value, with: {snapshot in
            if let data = snapshot.value as? NSArray {
                self.teamArray = []
                for i in 0...data.count-1{
                    let row = snapshot.childSnapshot(forPath: String(i))
                    if let tempTeamName = row.childSnapshot(forPath: "teamName").value{
                        if let tempCityID = row.childSnapshot(forPath: "teamCity").value{
                            let week = row.childSnapshot(forPath: "weeklySchedule")
                            var tempWeekArray = [Day]()
                            for j in 0...6{
                                let run = week.childSnapshot(forPath: "\(j)")
                                tempWeekArray.append(Day(dayName: run.childSnapshot(forPath: "dayName").value as! String, run: Run(index: j,dayID: run.childSnapshot(forPath: "day").value as? Int, dayName: run.childSnapshot(forPath: "dayName").value as? String, monthID: run.childSnapshot(forPath: "month").value as? Int, yearID: run.childSnapshot(forPath: "year").value as? Int , distance: run.childSnapshot(forPath: "distance").value as? Int, team: tempTeamName as? String, city: tempCityID as? Int, status: run.childSnapshot(forPath: "runStatus").value as? String, beginnerFriendly: run.childSnapshot(forPath: "beginnerFriendly").value as? String, place: run.childSnapshot(forPath: "place").value as? String, hour: run.childSnapshot(forPath: "hour").value as? String), team: tempTeamName as? String))

                            }
                            
                            
                            self.teamArray.append(Team(teamName: tempTeamName as! String,weekly: tempWeekArray) )

                            
                            
                        }
                        
                    }
                }
                // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
                
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
                self.delegate?.teamListLoaded()
                
                // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

                
            }

        }
        )
        database.child("users").observeSingleEvent(of: .value, with: {snapshot in
            if let data = snapshot.value as? NSArray{
                self.userArray = []
                for i in 0...data.count-1{
                    let row = snapshot.childSnapshot(forPath: String(i))
                    let city = row.childSnapshot(forPath: "city")
                    if let tempUserName = row.childSnapshot(forPath: "username").value,
                       let tempeMail = row.childSnapshot(forPath: "email").value,
                       let tempCityID = city.childSnapshot(forPath: "cityID").value,
                       let tempCityName = city.childSnapshot(forPath: "cityName").value,
                       let tempPassword = row.childSnapshot(forPath: "password").value,
                       let teamName = row.childSnapshot(forPath: "team").value{
                        self.userArray.append(User (username: tempUserName as! String, email: tempeMail as! String,password: tempPassword as? String, team: teamName as? String, city: (City(cityID: tempCityID as! Int, cityName: tempCityName as! String))))
                        
                    }
                }
                self.delegate?.userListLoaded()
            }else{
 
                return
            }
        })
        database.child("cities").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? NSArray {
                self.cityArray = []
                for i in 0...data.count{
                    let value = snapshot.childSnapshot(forPath: String(i))
                    let cityID = value.childSnapshot(forPath: "cityID").value
                    let cityName = value.childSnapshot(forPath: "cityName").value
                    var city = City(cityID: 0,cityName: "A")
                    city.cityID = cityID as! Int
                    city.cityName = cityName as! String
                    self.cityArray.append(city)
                    if cityID as! Int == 81 {
                        self.delegate?.cityListLoaded()
                        return;
                    }

                }
                          
            }
            
            })

        
    }
}

