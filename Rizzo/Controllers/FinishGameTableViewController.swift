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

    var buttonPlayer: AVAudioPlayer?
    var getCorrectQuestion = 0
    var getPreScene = ""
    let TURNON = 1
    let TURNOFF = 0
    @IBOutlet weak var numCorrect: UILabel!
    @IBOutlet weak var numUncorrect: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if getPreScene == "ImageQuestion" {
            performSegue(withIdentifier: "ToImgQuestionAgain", sender: self)
        }
        else if getPreScene == "SoundQuestion" {
            performSegue(withIdentifier: "ToSoundQuestionAgain", sender: self)
        }
    }
    

}
