//
//  ImageQuestionViewController.swift
//  Rizzo
//
//  Created by punyawee  on 6/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class ImageQuestionViewController: UIViewController {
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var popupReply: UILabel!
    @IBOutlet weak var popupAnswer: UILabel!
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var myPopup: UIView!
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet var myButtons: [UIButton]!
    var questions: [ImageQuestion] = []
    var bufferQuestions: [ImageQuestion] = []
    var buttonPlayer: AVAudioPlayer?
    var currentNumQuestion = 0
    var currentAnswer: String = ""
    var correctQuestion = 0
    let TURNON = 1
    let TURNOFF = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myPopup.bounds.size.width = self.view.bounds.width - 200
        self.myPopup.bounds.size.height = self.view.bounds.height / 2
        self.preview.bounds.size.width = self.view.bounds.width - 20
        self.preview.bounds.size.height = self.view.bounds.height - 20
        setCurrentQuestion()
        self.bufferQuestions = Datas.getImageQuestion()
//        for i in self.bufferQuestions {
//            if i.answers.count != 4 {
//                print(i.answer)
//                print("Error")
//            }
//            if UIImage(named: i.answer) == nil {
//                      print("\(i.answer) Error image")
//            }
//        }
        self.questions = chooseImageQuestion(10)
        setQuestion()
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
    
    func chooseImageQuestion(_ number: Int) -> [ImageQuestion] {
        var imageQuestions: [ImageQuestion] = []
        var i = 1
        while i <= number {
            let random = Int(arc4random_uniform(UInt32(self.bufferQuestions.count)))
            if (imageQuestions.index { (imageQuestion) -> Bool in
                return imageQuestion.answer == self.bufferQuestions[random].answer
            }) == nil {
                imageQuestions.append(self.bufferQuestions[random])
                i += 1
            }
        }
        return imageQuestions
    }
    
    func setQuestion() {
        let numOfQuestion = Int(arc4random_uniform(UInt32(self.questions.count)))
        let question = self.questions[numOfQuestion]
        self.currentAnswer = question.answer
        self.questionImage.image = UIImage(named: question.answer)
        for i in 0...3 {
            self.myButtons[i].setTitle(question.answers[i], for: .normal)
        }
        self.questions.remove(at: numOfQuestion)
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        playButton()
    }
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchedAnswer(_ sender: UIButtonX) {
        playButton()
        if self.currentAnswer == sender.currentTitle {
            self.correctQuestion += 1
            setupCorrectPopup(sender.currentTitle!)
        }
        else {
            setupUnCorrectPopup(sender.currentTitle!)
        }
        disableAnswerButtons()
        insidePopup()
    }
    
    func setupCorrectPopup(_ reply: String) {
        self.popupLabel.text = "ถูกต้องนะครับ"
        self.popupLabel.textColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        self.popupReply.text = reply
        self.popupReply.textColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        self.popupAnswer.text = ""
    }
    
    func setupUnCorrectPopup(_ reply: String) {
        self.popupLabel.text = "ไม่ถูกต้อง"
        self.popupLabel.textColor = UIColor(red: 246/255.0, green: 84/255.0, blue: 106/255.0, alpha: 1)
        self.popupReply.text = reply
        self.popupReply.textColor = UIColor(red: 246/255.0, green: 84/255.0, blue: 106/255.0, alpha: 1)
        self.popupAnswer.text = "คำตอบคือ \(self.currentAnswer)"
    }
    
    func insidePopup() {
        self.myPopup.alpha = 0.5
        self.view.addSubview(self.myPopup)
        self.myPopup.center = self.view.center
        self.myPopup.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.myPopup.alpha = 1
            self.myPopup.transform = CGAffineTransform.identity
        })
    }
    
    func disableAnswerButtons() {
        for i in 0...3 {
            self.myButtons[i].isEnabled = false
        }
    }
    
    func ableAnswerButtons() {
        for i in 0...3 {
            self.myButtons[i].isEnabled = true
        }
    }
    
    func setCurrentQuestion() {
        self.currentNumQuestion += 1
        self.currentQuestion.text = "ข้อที่ \(self.currentNumQuestion) / 10"
    }
    
    @IBAction func onNext(_ sender: UIButtonX) {
        playButton()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.myPopup.alpha = 0
            self.myPopup.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
        }) { (true) in
            self.myPopup.removeFromSuperview()
            if self.questions.isEmpty {
                print(self.correctQuestion)
                
                self.performSegue(withIdentifier: "ToFinishQuestion", sender: self)
            }
            else {
                UIView.transition(with: self.myView, duration: 0.4, options: [.transitionCrossDissolve], animations: {
                    self.myView.alpha = 0
                }, completion: { (true) in
                    self.setQuestion()
                    self.setCurrentQuestion()
                    UIView.transition(with: self.myView, duration: 0.4, options: [.transitionCrossDissolve], animations: {
                        self.myView.alpha = 1
                    }, completion: { (true) in
                        self.ableAnswerButtons()
                    })
                })
            }
        }
    }
    
    @IBAction func onPreviewImage(_ sender: UIButton) {
        playButton()
        self.imagePreview.image = self.questionImage.image
        self.preview.alpha = 0.5
        self.view.addSubview(self.preview)
        self.preview.center = self.view.center
        self.preview.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.preview.alpha = 1
            self.preview.transform = CGAffineTransform.identity
        })
    }
    
    @IBAction func onClosePreview(_ sender: UIButtonX) {
        playButton()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.preview.alpha = 0
            self.preview.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
        })
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFinishQuestion" {
            let destination = segue.destination as! FinishGameTableViewController
            destination.getCorrectQuestion = self.correctQuestion
            destination.getPreScene = "ImageQuestion"
        }
    }
    
}
