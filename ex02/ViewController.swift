//
//  ViewController.swift
//  ex02
//
//  Created by Zenande GODONGWANA on 2018/10/01.
//  Copyright © 2018 Zenande GODONGWANA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstNumberText = ""
    var secondNumberText = ""
    var op = ""
    var isFirstNumber = true
    var hasOp = false
    var canClear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleButtonPress(_ sender: UIButton) {
        if canClear {
            resultLabel.text = ""
            canClear = false
        }
        var currentText = resultLabel.text!
        let textLabel = sender.titleLabel?.text
        if let text = textLabel {
            switch text {
            case "+", "*", "/", "-":
                if hasOp {
                    if (firstNumberText != "" && secondNumberText != "") {
                        let result = calculate()
                        if (result != nil) {
                            firstNumberText = "\(result!)"
                            currentText = "\(result!)"
                        } else {
                            firstNumberText = ""
                            secondNumberText = ""
                            resultLabel.text = "Undefined"
                            return
                        }
                    } else {
                        return
                    }
                }
                op = text
                isFirstNumber = false
                hasOp = true
                resultLabel.text = "\(currentText) \(op) "
                break
            case "=":
                isFirstNumber = true
                hasOp = false
                canClear = true
                if (firstNumberText != "" && secondNumberText != "") {
                    let result = calculate()
                    if result != nil {
                        resultLabel.text = "\(result!)"
                    } else {
                        resultLabel.text = "Undefined"
                    }
                }
                break
            case "AC":
                firstNumberText = ""
                secondNumberText = ""
                resultLabel.text = ""
                break;
            case "NEG":
                if (firstNumberText != "" && secondNumberText == "") {
                    firstNumberText = "-" + firstNumberText;
                }
                else if (firstNumberText != "" && secondNumberText != "") {
                    secondNumberText = "-" + secondNumberText;
                }
            default:
                if isFirstNumber {
                    firstNumberText = "\(firstNumberText)\(text)"
                } else {
                    secondNumberText = "\(secondNumberText)\(text)"
                }
                resultLabel.text = "\(currentText)\(text)"
                break;
            }
        }
    }
    
    func calculate() -> Double? {
        let firstNumber = Double(firstNumberText)!
        let secondNumber = Double(secondNumberText)!
        firstNumberText = ""
        secondNumberText = ""
        switch op {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "*":
            return firstNumber * secondNumber
        case "/":
            if (secondNumber == 0.0) {
                return nil
            }
            return firstNumber / secondNumber
        default:
            return 0
        }
    }
}
