//
//  MenuCollectionViewCell.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    func setUp(_ image: UIImage) {
        self.menuImage.image = image
    }
}
