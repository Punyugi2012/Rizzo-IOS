//
//  FinishDrawQuestionTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 10/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import Alamofire

class FinishDrawQuestionTableViewController: UITableViewController {

    @IBOutlet weak var myRecogView: UIView!
    @IBOutlet weak var firstTextRecogView: UILabel!
    @IBOutlet weak var secondTextRecogView: UILabel!
    @IBOutlet weak var imageDrawed: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    var params: Parameters!
    var question: DrawQuestion!
    var imageDraw: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.myRecogView.bounds.size.width = self.view.bounds.width
        self.myRecogView.bounds.size.height = self.view.bounds.height
        recogViewInside()
        let url = URL(string: "https://inputtools.google.com/request?ime=handwriting&app=quickdraw&dbg=1&cs=1&oe=UTF-8")
        Alamofire.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .failure:
                print(response.error!)
            case .success:
                var result = ""
                if let data = response.result.value as? [Any],
                let data2 = data[1] as? [Any],
                let data3 = data2[0] as? [Any],
                let data4 = data3[1] as? [String] {
                    if !data4.isEmpty {
                        result = data4[0]
                    }
                }
                print(result)
                self.questionLabel.text = "โจทย์ จงวาด\(self.question.question)"
                self.imageDrawed.image = self.imageDraw
                if result.contains(self.question.answer) {
                    self.resultLabel.text = "ถูกต้องมันคือ \(self.question.question)"
                }
                else {
                    self.resultLabel.text = "ไม่ถูกต้องมันยังไม่ใช่ \(self.question.question)"
                }
                sleep(1)
                self.recogViewOutside()
            }
        }
    }
    
    func recogViewInside() {
        self.view.addSubview(self.myRecogView)
        self.myRecogView.center = self.view.center
    }
    
    func recogViewOutside() {
        UIView.animate(withDuration: 0.5, animations: {
            self.firstTextRecogView.text = "เสร็จสิ้น"
            self.secondTextRecogView.text = ""
        }) { (true) in
            sleep(1)
            UIView.transition(with: self.myRecogView, duration: 0.4, options: [.transitionCrossDissolve], animations: {
                self.myRecogView.alpha = 0
            }) { (true) in
                self.myRecogView.removeFromSuperview()
            }
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
