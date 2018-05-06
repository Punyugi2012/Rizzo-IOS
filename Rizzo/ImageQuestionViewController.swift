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
    
   
    @IBOutlet weak var popupReply: UILabel!
    @IBOutlet weak var popupAnswer: UILabel!
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet var myPopup: UIView!
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet var myButtons: [UIButton]!
    var questions: [ImageQuestion] = []
    var bufferQuestions: [ImageQuestion] = []
    var buttonPlayer = AVAudioPlayer()
    var popupPlayer = AVAudioPlayer()
    var currentNumQuestion = 0
    var currentAnswer: String = ""
    var correctQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
            buttonPlayer.prepareToPlay()
        }catch{
            print(error)
        }
        do {
            popupPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "popup", ofType: "mp3")!))
            popupPlayer.prepareToPlay()
        }catch{
            print(error)
        }
        self.myPopup.bounds.size.width = self.view.bounds.width - 200
        self.myPopup.bounds.size.height = self.view.bounds.height / 2
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
        self.buttonPlayer.stop()
        self.buttonPlayer.currentTime = 0
        self.buttonPlayer.play()
    }
    
    func playPopup() {
        self.popupPlayer.stop()
        self.popupPlayer.currentTime = 0
        self.popupPlayer.play()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchedAnswer(_ sender: UIButtonX) {
        playPopup()
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
//        self.myPopup.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        self.popupLabel.text = "ถูกต้องนะครับ"
        self.popupLabel.textColor = UIColor.green
        self.popupReply.text = reply
        self.popupReply.textColor = UIColor.green
        self.popupAnswer.text = ""
    }
    
    func setupUnCorrectPopup(_ reply: String) {
//        self.myPopup.backgroundColor = UIColor(red: 255/255.0, green: 68/255.0, blue: 68/255.0, alpha: 1)
        self.popupLabel.text = "ไม่ถูกต้องนะครับ"
        self.popupLabel.textColor = UIColor.red
        self.popupReply.text = reply
        self.popupReply.textColor = UIColor.red
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
    
}
