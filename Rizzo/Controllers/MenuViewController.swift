//
//  MenuViewController.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet weak var alertConnectionView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    var audioPlayer = AVAudioPlayer()
    var buttonPlayer: AVAudioPlayer?
    let menus = ["ทายเสียง", "ทายรูปภาพ", "วาดภาพ", "ตั้งค่า"]
    let TURNON = 1
    let TURNOFF = 0
    var reachablity: Reachability!
    var isPopup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAlertView()
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        reachablity = Reachability()
        setButtonSound()
        setBackgroundSound()
    }
    
    @IBAction func closeAlert(_ sender: UIButtonX) {
        playButton()
        alertOutside()
        self.menuCollectionView.allowsSelection = true
    }
    
    func setAlertView() {
        self.alertConnectionView.bounds.size.width = self.view.bounds.width - 200
        self.alertConnectionView.bounds.size.height = self.view.bounds.height / 2
        self.alertConnectionView.layer.cornerRadius = 20
        self.alertConnectionView.clipsToBounds = true
    }
    
    func alertInside() {
        self.alertConnectionView.alpha = 0.5
        self.view.addSubview(self.alertConnectionView)
        self.alertConnectionView.center = self.view.center
        self.alertConnectionView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.alertConnectionView.alpha = 1
            self.alertConnectionView.transform = CGAffineTransform.identity
        })
    }
    
    func alertOutside() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.alertConnectionView.alpha = 0
            self.alertConnectionView.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
        })
    }
    
    func isConnection() -> Bool {
        if self.reachablity.connection == .none {
            return false
        }
        return true
    }
    
    
    func setBackgroundSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "soundtrack", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            if let data = UserDefaults.standard.value(forKey: "bgSoundConfig") as? Int
            {
                if data == TURNON {
                    audioPlayer.play()
                }
                else {
                    audioPlayer.stop()
                    audioPlayer.currentTime = 0
                }
            }
            else {
                UserDefaults.standard.set(TURNON, forKey: "bgSoundConfig")
                audioPlayer.play()
            }
        }catch{
            print(error)
        }
    }
    
    func setButtonSound() {
        if let data = UserDefaults.standard.value(forKey: "btnSoundConfig") as? Int {
            if data == TURNON {
                do {
                    buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
                    buttonPlayer?.prepareToPlay()
                }catch{
                    print(error)
                }
            }
            else {
                buttonPlayer = nil
            }
        }
        else {
            UserDefaults.standard.set(TURNON, forKey: "btnSoundConfig")
            do {
                buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
                buttonPlayer?.prepareToPlay()
            }catch{
                print(error)
            }
        }
    }
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSetting" {
            let destination = segue.destination as! SettingTableViewController
            destination.getAudioPlayer = self.audioPlayer
        }
        if segue.identifier == "ToPrePareSoundQuestion" {
            let destination = segue.destination as! PrepareSoundQTableViewController
            destination.bgSoundPlayer = self.audioPlayer
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        setButtonSound()
        if let data = UserDefaults.standard.value(forKey: "bgSoundConfig") as? Int {
            if data == TURNON {
                self.audioPlayer.play()
            }
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playButton()
        if self.menus[indexPath.row] == "ตั้งค่า" {
            performSegue(withIdentifier: "ToSetting", sender: self)
        }
        else {
            if isConnection() {
                if self.menus[indexPath.row] == "ทายรูปภาพ" {
                    performSegue(withIdentifier: "ToPrePareImgQuestion", sender: self)
                }
                if self.menus[indexPath.row] == "ทายเสียง" {
                    performSegue(withIdentifier: "ToPrePareSoundQuestion", sender: self)
                }
                if self.menus[indexPath.row] == "วาดภาพ" {
                    performSegue(withIdentifier: "ToPrepareDrawQuestion", sender: self)
                }
            }
            else {
                self.menuCollectionView.allowsSelection = false
                alertInside()
            }
        }
    }
}
