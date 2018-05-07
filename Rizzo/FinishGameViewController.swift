//
//  FinishGameViewController.swift
//  Rizzo
//
//  Created by punyawee  on 7/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

class FinishGameViewController: UITableViewController {

    var getCorrectQuestion = 0
    @IBOutlet weak var numCorrect: UILabel!
    @IBOutlet weak var numUncorrect: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numCorrect.text = "\(getCorrectQuestion) ข้อ"
        self.numUncorrect.text = "\(10 - getCorrectQuestion) ข้อ"
    }



}
