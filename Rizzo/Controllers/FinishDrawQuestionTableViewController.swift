//
//  FinishDrawQuestionTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 10/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class FinishDrawQuestionTableViewController: UITableViewController {

    @IBOutlet weak var alertConnectionView: UIView!
    @IBOutlet weak var myRecogView: UIView!
    @IBOutlet weak var firstTextRecogView: UILabel!
    @IBOutlet weak var secondTextRecogView: UILabel!
    @IBOutlet weak var imageDrawed: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButtonX!
    var buttonPlayer: AVAudioPlayer?
    var params: Parameters!
    var question: DrawQuestion!
    var imageDraw: UIImage!
    let TURNON = 1
    let TURNOFF = 0
    var reachablity: Reachability!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.myRecogView.bounds.size.width = self.view.bounds.width
        self.myRecogView.bounds.size.height = self.view.bounds.height
        self.reachablity = Reachability()
        setAlertView()
        recogViewInside()
        let url = URL(string: "https://inputtools.google.com/request?ime=handwriting&app=quickdraw&dbg=1&cs=1&oe=UTF-8")
        Alamofire.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .failure:
                print(response.error!)
            case .success:
//                var result = ""
                var isCorrect = false
//                print(response.result.value)
                if let data = response.result.value as? [Any],
                let data2 = data[1] as? [Any],
                let data3 = data2[0] as? [Any],
                let data4 = data3[1] as? [String] {
                    for element in data4 {
                        if element.contains(self.question.answer) {
                            isCorrect = true
                            break
                        }
                    }
                }
//                print(result)
                self.questionLabel.text = "โจทย์ จงวาด\(self.question.question)"
                self.imageDrawed.image = self.imageDraw
                if isCorrect {
                    self.resultLabel.text = "ถูกต้องมันคือ \(self.question.question)"
                }
                else {
                    self.resultLabel.text = "ไม่ถูกต้องมันยังไม่ใช่ \(self.question.question)"
                }
                sleep(1)
                self.setButtonSound()
                self.recogViewOutside()
            }
        }
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
    func recogViewInside() {
        self.view.addSubview(self.myRecogView)
        self.myRecogView.center = self.view.center
    }
    
    func recogViewOutside() {
        self.firstTextRecogView.text = "เสร็จสิ้น"
        self.secondTextRecogView.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.transition(with: self.myRecogView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                self.myRecogView.alpha = 0
            }) { (true) in
                self.myRecogView.removeFromSuperview()
            }
        }
    }
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
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
    
    @IBAction func onPlayAgain(_ sender: UIButton) {
        playButton()
        if isConnection() {
            performSegue(withIdentifier: "ToDrawQuestionAgain", sender: self)
        }
        else {
            alertInside()
            self.playAgainBtn.isEnabled = false
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

  

}
