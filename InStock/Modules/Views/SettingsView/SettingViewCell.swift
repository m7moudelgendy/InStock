//
//  SettingViewCell.swift
//  InStock
//
//  Created by ElGendy on 12/03/2023.
//

import UIKit

class SettingViewCell: UITableViewCell {

    @IBOutlet weak var settingLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var arrowImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
