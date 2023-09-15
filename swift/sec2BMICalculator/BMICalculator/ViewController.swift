//
//  ViewController.swift
//  BMICalculator
//
//  Created by Sean Campbell on 1/17/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var heightText: UILabel!
    @IBOutlet weak var weightText: UILabel!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var bmiText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.heightText.delegate = self
//        self.weightText.delegate = self
        var height = self.heightSlider.value
        var weight = self.weightSlider.value
        
        var bmi = (weight/(height*height))*703
        
        self.bmiText.text = "\(bmi)"
        self.resultText.text = "You Are Normal"
        self.resultText.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func heightChange(_ sender: UISlider) {
        var height = self.heightSlider.value
        var weight = self.weightSlider.value
        height.round()
        weight.round()
        self.heightText.text = "\(height)\""
        self.heightText.sizeToFit()
        var bmi = (weight/(height*height))*703
        bmi.round()
        
        self.bmiText.text = "\(bmi)"
        
        if bmi < 18 {
            self.resultText.text = "You Are Underweight"
            self.resultText.textColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        } else if bmi >= 18 && bmi < 25 {
            self.resultText.text = "You Are Normal"
            self.resultText.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        } else if bmi >= 25 && bmi <= 30 {
            self.resultText.text = "You Are Pre-Obese"
            self.resultText.textColor = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
        } else {
            self.resultText.text = "You Are Obese"
            self.resultText.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func weightChanged(_ sender: UISlider) {
        var height = self.heightSlider.value
        var weight = self.weightSlider.value
        weight.round()
        self.weightText.text = "\(weight) lbs"
        self.weightText.sizeToFit()
        var bmi = (weight/(height*height))*703
        bmi.round()
        
        self.bmiText.text = "\(bmi)"
        
        if bmi < 18 {
            self.resultText.text = "You Are Underweight"
            self.resultText.textColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        } else if bmi >= 18 && bmi < 25 {
            self.resultText.text = "You Are Normal"
            self.resultText.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        } else if bmi >= 25 && bmi <= 30 {
            self.resultText.text = "You Are Pre-Obese"
            self.resultText.textColor = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
        } else {
            self.resultText.text = "You Are Obese"
            self.resultText.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
}

