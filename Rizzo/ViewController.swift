//
//  ViewController.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let menus = ["ทายเสียง", "ทายรูปภาพ", "วาดภาพ", "ตั้งค่า"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        cell.myImage.image = UIImage(named: self.menus[indexPath.row])
        cell.myLabel.text = self.menus[indexPath.row]
        cell.myLabel.font = UIFont(name: cell.myLabel.font.fontName, size: 30)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 70 , height: (view.frame.height / 2) - 100)
    }
    
    
    
}

