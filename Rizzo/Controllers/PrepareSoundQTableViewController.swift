//
//  PrepareSoundQTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 7/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class PrepareSoundQTableViewController: UITableViewController {

    @IBOutlet weak var alertConnectionView: UIView!
    @IBOutlet weak var playBtn: UIButton!
    var bgSoundPlayer: AVAudioPlayer!
    var buttonPlayer: AVAudioPlayer?
    let TURNON = 1
    let TURNOFF = 0
    var reachablity: Reachability!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        setButtonSound()
        setAlertView()
        self.reachablity = Reachability()
    }
    
    @IBAction func closeAlert(_ sender: UIButtonX) {
        playButton()
        alertOutside()
        self.playBtn.isEnabled = true
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
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    @IBAction func onPlay(_ sender: UIButton) {
        playButton()
        if isConnection() {
            performSegue(withIdentifier: "ToSoundQuestion", sender: self)
            bgSoundPlayer.pause()
        }
        else {
            alertInside()
            self.playBtn.isEnabled = false
        }
    }
    @IBAction func onClose(_ sender: UIButton) {
        playButton()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
