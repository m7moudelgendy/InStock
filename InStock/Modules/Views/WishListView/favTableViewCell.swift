//
//  favTableViewCell.swift
//  InStock
//
//  Created by Hader on 10/3/23.
//

import UIKit

class favTableViewCell: UITableViewCell {

    @IBOutlet weak var proPrice: UILabel!
    @IBOutlet weak var proName: UILabel!
    @IBOutlet weak var proImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
