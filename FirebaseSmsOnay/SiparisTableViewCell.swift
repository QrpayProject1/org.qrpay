//
//  SiparisTableViewCell.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/14/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class SiparisTableViewCell: UITableViewCell {

    
    @IBOutlet weak var OrderCode: UILabel!
    
    @IBOutlet weak var OrderProductName: UILabel!
    
    @IBOutlet weak var OrderUnitPrice: UILabel!
    
    @IBOutlet weak var OrderPaymentMethod: UILabel!
    
    @IBOutlet weak var OrderTotalPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
