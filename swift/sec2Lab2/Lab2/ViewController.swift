//
//  ViewController.swift
//  Lab2
//
//  Created by Sean Campbell on 1/31/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weightText: UITextField!
    
    @IBOutlet weak var returnLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! SecondViewController
        let weight: Int? = Int(weightText.text!)
        if(segue.identifier == "toView2") {
            des.earthWeight = weight
        }
    }
    
    @IBAction func fromSecond(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? SecondViewController {
            if let dataReceived = sourceViewController.returnMessage {
                returnLabel.text = dataReceived
                returnLabel.sizeToFit()
                returnLabel.center.x = self.view.center.x
            }
        }
        else if let sourceViewController2 = segue.source as? ThirdViewController {
            if let dataReceived = sourceViewController2.returnMessage {
                returnLabel.text = dataReceived
                returnLabel.sizeToFit()
                returnLabel.center.x = self.view.center.x
            }
        }
    }

}

