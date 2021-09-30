//
//  CardSearchTableViewCell.swift
//  rappypaytest
//
//  Created by Enar GoMez on 25/09/21.
//

import UIKit

class CardSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
