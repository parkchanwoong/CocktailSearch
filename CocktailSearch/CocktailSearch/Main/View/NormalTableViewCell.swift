//
//  NormalTableViewCell.swift
//  CocktailSearch
//
//  Created by 박찬웅 on 2020/10/20.
//

import UIKit

class NormalTableViewCell: UITableViewCell, Resuable {

    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(_ item: MainModel) {
        title.text = item.title
    }
    
}
