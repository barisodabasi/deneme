//
//  ZikirCell.swift
//  deneme
//
//  Created by BarisOdabasi on 28.03.2021.
//

import UIKit

class ZikirCell: UITableViewCell {

    @IBOutlet weak var zikirAdiLabel: UILabel!
    @IBOutlet weak var zikirSayiLabel: UILabel!

var zikirAdiArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func devamEtButton(_ sender: Any) {
    }
    
    @IBAction func duzenleButton(_ sender: Any) {
    }
    
    @IBAction func silButton(_ sender: Any) {
    }
}
