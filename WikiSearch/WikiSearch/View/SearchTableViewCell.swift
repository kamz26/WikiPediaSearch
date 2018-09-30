//
//  SearchTableViewCell.swift
//  WikiSearch
//
//  Created by user142467 on 9/29/18.
//  Copyright © 2018 user142467. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText:UILabel!
    static let  reuseIndentifier:String = Constants.CellIdentifier.cellIdentifier
    static let  nib:UINib = UINib(nibName: Constants.CellIdentifier.nibIdentifier, bundle: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
