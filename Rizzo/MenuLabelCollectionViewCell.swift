//
//  MenuLabelCollectionViewCell.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class MenuLabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    func setUp(_ name: String) {
        self.labelName.text = name
    }
}
