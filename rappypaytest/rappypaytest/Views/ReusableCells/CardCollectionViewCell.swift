//
//  CardCollectionViewCell.swift
//  rappypaytest
//
//  Created by Enar GoMez on 25/09/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CardTitle: UILabel!
    @IBOutlet weak var cardIcon: UIImageView!
    @IBOutlet weak var CardIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.contentView.layer.borderWidth = 1.0
    }
}
