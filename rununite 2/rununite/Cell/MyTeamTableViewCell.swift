//
//  MyTeamTableViewCell.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class MyTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var runStatusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
