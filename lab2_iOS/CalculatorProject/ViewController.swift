//
//  ViewController.swift
//  CalculatorProject
//
//  Created by erumaru on 1/25/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = Calculator()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    var click = true
    @IBAction func numberPressed(_ sender: UIButton) {
        guard
            let numberText = sender.titleLabel?.text
        else { return }
        
     
        if click {
            let currentNumber = resultLabel.text!
            //if resultLabel.text != "0" {
                resultLabel.text = currentNumber + numberText
            
        } else {
            resultLabel.text = numberText
            click = true
        }
        //resultLabel.text?.append(numberText)
    }
    
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let numberText = resultLabel.text,
            let number = Double(numberText),
            let operation = sender.titleLabel?.text
        else {
            return
        }
        model.setOperand(number: number)
        model.executeOperation(symbol: operation)
        resultLabel.text = "\(model.result)"
        click = false

        
//        if operation == "=" {
//            resultLabel.text = "\(model.result)"
//        }
    }
}

