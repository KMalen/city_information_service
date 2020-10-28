//
//  ObjectOwnerTableViewCell.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/28/20.
//

import UIKit

class ObjectOwnerTableViewCell: UITableViewCell {

    @IBOutlet weak var textOwnerObjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
