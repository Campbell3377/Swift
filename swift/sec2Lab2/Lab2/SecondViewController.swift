//
//  SecondViewController.swift
//  Lab2
//
//  Created by Sean Campbell on 1/31/23.
//

import UIKit

class SecondViewController: UIViewController {
    var earthWeight:Int?
    var returnMessage:String?
    @IBOutlet weak var earthText: UILabel!
    @IBOutlet weak var moonWeight: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let weight = earthWeight {
            earthText.text = "\(weight) lbs"
            
            let moon:Double = Double(weight)/6.0
            let moonText = String(format: "%.2f", moon)
            moonWeight.text = "\(moonText) lbs"
            
            moonWeight.sizeToFit()
            earthText.sizeToFit()
            
            returnMessage = "Coming from the Moon!"
        }
        else {
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toView3") {
            let des = segue.destination as! ThirdViewController
            let weight: Int? = earthWeight
            des.earthWeight = weight
        }
    }
    
    @IBAction func fromThird(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? ThirdViewController {
            if let dataReceived = sourceViewController.returnMessage {
                returnLabel.text = dataReceived
                returnLabel.sizeToFit()
                returnLabel.center.x = self.view.center.x
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
