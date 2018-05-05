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
    @IBOutlet weak var menuName: UILabel!
    func setUp(_ image: UIImage, _ name: String) {
        self.menuImage.image = image
        self.menuName.text = name
    }
}
