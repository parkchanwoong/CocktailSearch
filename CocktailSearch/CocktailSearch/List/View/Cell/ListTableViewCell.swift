//
//  ListTableViewCell.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/15.
//

import UIKit

class ListTableViewCell: UITableViewCell, Resuable {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(_ info: AlcoholInfo) {
        itemLabel.text = info.productName
        itemImageView.kf.setImage(with: URL(string: info.productImageName))
    }
    
}
