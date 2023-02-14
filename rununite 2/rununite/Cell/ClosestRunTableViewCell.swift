//
//  ClosestRunTableViewCell.swift
//  rununite
//
//  Created by Lab on 13.01.2023.
//

import UIKit

class ClosestRunTableViewCell: UITableViewCell {

   
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
/*
 cell.teamNameLabel.text = run.team
 cell.placeLabel.text = run.place
 cell.distanceLabel.text = "\(run.distance ?? 0)"
 print("here")
 if let time = run.hour,
    let day = run.dayName{
     let hour = "\(day) - \(time.prefix(time.count - 2)):\(time.suffix(2))"
     cell.timeLabel.text = hour
     print(hour)
 }
 */
