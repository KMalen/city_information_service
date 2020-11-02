//
//  CityObjectTableViewCell.swift
//  city_information_service
//
//  Created by Kiril Malenchik on 10/23/20.
//

import UIKit

class CityObjectTableViewCell: UITableViewCell {

    @IBOutlet weak var textObjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
