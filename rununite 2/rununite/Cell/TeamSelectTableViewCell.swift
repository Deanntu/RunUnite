//
//  TeamSelectTableViewCell.swift
//  rununite
//
//  Created by Lab on 15.01.2023.
//

import UIKit

class TeamSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var teamNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

        var ClousureBtnActionHandler:((_ sender: AnyObject) -> Void)?


        @IBAction func btnInfoActionHandler(_ sender : AnyObject) {
            if self.ClousureBtnActionHandler != nil {
                self.ClousureBtnActionHandler!(sender)
            }
        }
    
}
