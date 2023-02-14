//
//  TeamDetailTableViewCell.swift
//  rununite
//
//  Created by Lab on 14.01.2023.
//

import UIKit

class TeamDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var runStatusLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
