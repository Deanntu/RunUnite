//
//  SetCityViewController.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class SetCityViewController: UIViewController {
   
    @IBOutlet weak var cityTableView: UITableView!
    
    var user: User?
    private let dataSource = SharedDataSource()
    private var cityArray: [City] = []
    var delegate: SetCityViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Set City"
        dataSource.delegate = self
        cityTableView.allowsSelection = true
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
}

extension SetCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        user?.city = cityArray[indexPath.row]
    
        delegate?.setCityViewControllerResponse(user: user!)
        
        _ = navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as? CityTableViewCell else {
            return UITableViewCell()
        }
        let city = cityArray[indexPath.row]
        cell.cityNameLabel.text = city.cityName.uppercased(with: Locale(identifier: "tr_TR"))
        
        return cell
    }
    
}
protocol SetCityViewControllerDelegate{
    func setCityViewControllerResponse(user: User)
}
extension SetCityViewController: SharedDataDelegate {
    func userListLoaded() {
        
    }
    
    func teamListLoaded() {
        
    }
    
    func cityListLoaded() {
        cityArray = dataSource.getCityArray()
        cityTableView.reloadData()
    }
}
