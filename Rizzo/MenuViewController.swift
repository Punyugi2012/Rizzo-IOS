//
//  MenuViewController.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    var audioPlayer = AVAudioPlayer()
    var buttonPlayer = AVAudioPlayer()
    let menus = ["ทายเสียง", "ทายรูปภาพ", "วาดภาพ", "ตั้งค่า"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "soundtrack", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }catch{
            print(error)
        }
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
            buttonPlayer.prepareToPlay()
        }catch{
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCollectionViewCell
        cell.setUp(UIImage(named: self.menus[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 100 , height: (view.frame.height / 2) - 80)
    }
    
    func playButton() {
        self.buttonPlayer.stop()
        self.buttonPlayer.currentTime = 0
        self.buttonPlayer.play()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playButton()
        if self.menus[indexPath.row] == "ตั้งค่า" {
            performSegue(withIdentifier: "ToSetting", sender: self)
        }
        if self.menus[indexPath.row] == "ทายรูปภาพ" {
            performSegue(withIdentifier: "ToPrePareImgQuestion", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSetting" {
            let destination = segue.destination as! SettingTableViewController
            destination.getAudioPlayer = self.audioPlayer
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
