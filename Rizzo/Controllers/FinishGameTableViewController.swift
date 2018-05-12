//
//  FinishGameTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 7/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class FinishGameTableViewController: UITableViewController {

    @IBOutlet weak var alertConnectionView: UIView!
    var buttonPlayer: AVAudioPlayer?
    var getCorrectQuestion = 0
    var getPreScene = ""
    let TURNON = 1
    let TURNOFF = 0
    var reachablity: Reachability!
    @IBOutlet weak var numCorrect: UILabel!
    @IBOutlet weak var numUncorrect: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButtonX!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reachablity = Reachability()
        self.tableView.isScrollEnabled = false
        self.numCorrect.text = "\(getCorrectQuestion) ข้อ"
        self.numUncorrect.text = "\(10 - getCorrectQuestion) ข้อ"
        if self.getCorrectQuestion == 10 {
            self.skillLabel.text = "ว๊าวได้เต็ม เก่งมาก!"
        }
        else if self.getCorrectQuestion >= 7 {
            self.skillLabel.text = "ว๊าวเกือบได้เต็ม!"
        }
        else if self.getCorrectQuestion >= 1 {
            self.skillLabel.text = "เล่นเรื่อยๆ เดี๋ยวก็ได้เต็ม"
        }
        else {
            self.skillLabel.text = "ว๊า..แย่จัง ครั้งหน้าลองพยายามอีกนิด"
        }
        setButtonSound()
        setAlertView()
    }
    
    @IBAction func closeAlert(_ sender: UIButtonX) {
        playButton()
        alertOutside()
        self.playAgainBtn.isEnabled = true
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

    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func onPlayAgain(_ sender: UIButtonX) {
        playButton()
        if isConnection() {
            if getPreScene == "ImageQuestion" {
                performSegue(withIdentifier: "ToImgQuestionAgain", sender: self)
            }
            else if getPreScene == "SoundQuestion" {
                performSegue(withIdentifier: "ToSoundQuestionAgain", sender: self)
            }
        }
        else {
            alertInside()
            self.playAgainBtn.isEnabled = false
        }
    }
    

}
