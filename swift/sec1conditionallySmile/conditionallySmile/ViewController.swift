//
//  ViewController.swift
//  conditionallySmile
//
//  Created by user on 8/25/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var greetingText: UITextView!
    @IBOutlet weak var conditionalSmile: UIImageView!
    @IBOutlet weak var tempText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameText.delegate = self
        self.tempText.delegate = self
        self.greetingText.isHidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sayHello(_ sender: UIButton) {
        
        let temp:Int?
        let name:String?
        var greeting:String?
        
       // if  let t = Int(self.tempText.text!)
        if ((self.nameText.text?.count)! > 0), let t = Int(self.tempText.text!)
        {
            temp = Int(self.tempText.text!)
        
            name = self.nameText.text
       
          self.greetingText.isHidden=false
          
          if temp! > 95 {
           
            greeting = "Hello \(name!) \n its a bit toasty outside !"
            self.greetingText.text=greeting
            let image = UIImage(named: "angry.jpg");
            self.conditionalSmile.image=image
           
            
            
        } else if temp! > 70 {
            greeting = " Hello \(name!) \n its a nice  outside !"
            self.greetingText.text=greeting
            let image = UIImage(named: "smily.jpg");
            self.conditionalSmile.image=image
            
        } else {
            
            greeting = "Hello \(name!) \n its a bit chilly  outside !"
            self.greetingText.text=greeting
            let image = UIImage(named: "sadFace.jpg");
            self.conditionalSmile.image=image
            
        }
        
        
      }else
        {
            print("no data")
        }
        
    }
    
    // textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tempText.resignFirstResponder()
        self.nameText.resignFirstResponder()
        return true;
    }


}

