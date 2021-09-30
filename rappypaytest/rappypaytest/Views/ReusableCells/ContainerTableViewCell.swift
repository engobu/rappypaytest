//
//  ContainerTableViewCell.swift
//  rappypaytest
//
//  Created by Enar GoMez on 25/09/21.
//

import UIKit

protocol ContainerTableViewCellDelegate {
    func showDetailProgram(oProgram: Program)
}

class ContainerTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var arrPrograms: [Program] = [Program]()
    var _delegate: ContainerTableViewCellDelegate?
    let imageLoader: ImageService = ImageService()
    var programType:ProgramTypeEnum!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func update() {
        self.collectionView.reloadData()
    }
}

extension ContainerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPrograms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCVCell", for: indexPath) as! CardCollectionViewCell
        
        let oProgram : Program = arrPrograms[indexPath.row]
        cardCVCell.contentView.layer.cornerRadius = 5.0
        cardCVCell.layer.cornerRadius = 5.0
        cardCVCell.layer.borderWidth = 1.0
        
        cardCVCell.CardIndicator.isHidden = false
        cardCVCell.CardIndicator.startAnimating()
        imageLoader.loadImage(with: oProgram.backdropURL) { (success, image) in
            DispatchQueue.main.async{
                cardCVCell.CardIndicator.isHidden = true
                if success {
                    cardCVCell.cardIcon.image = image
                }else{
                    cardCVCell.cardIcon.image = UIImage(named: "ic_default")
                }
            }
        }
        
        cardCVCell.CardTitle.text = oProgram.getProgramName(type: programType)
        
        
        return cardCVCell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    // mark UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if _delegate != nil{
            _delegate?.showDetailProgram(oProgram: arrPrograms[indexPath.row])
        }
    }
}
