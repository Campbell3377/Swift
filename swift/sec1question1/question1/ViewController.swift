//
//  ViewController.swift
//  question1
//
//  Created by Sean Campbell on 1/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var welcome: UILabel!
    @IBAction func button(_ sender: Any) {
        let fName = self.firstNameField.text!
        let lName = self.lastNameField.text!
        
        print(fName)
        print(lName)
        self.welcome.text = "\(fName) \(lName) Welcome to CSE 335"
        self.welcome.textColor = UIColor.blue
        self.img.isHidden = false
        self.img.image = UIImage(named:"smily.jpg")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

