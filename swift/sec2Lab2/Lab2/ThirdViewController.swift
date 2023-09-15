//
//  ThirdViewController.swift
//  Lab2
//
//  Created by Sean Campbell on 1/31/23.
//

import UIKit

class ThirdViewController: UIViewController {
    var earthWeight:Int?
    var returnMessage:String?
    @IBOutlet weak var earthText: UILabel!
    @IBOutlet weak var jupiterText: UILabel!
    @IBOutlet weak var moonText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let weight = earthWeight {
            earthText.text = "\(weight) lbs"
            
            var moon:Double = Double(weight)/6.0
            var moonWeight = String(format: "%.2f", moon)
            moonText.text = "\(moonWeight) lbs"
            
            var jupiter:Double = Double(weight)*2.4
            var jupiterWeight = String(format: "%.2f", jupiter)
            jupiterText.text = "\(jupiterWeight) lbs"
            
            moonText.sizeToFit()
            earthText.sizeToFit()
            jupiterText.sizeToFit()
            
            returnMessage = "Coming from Jupiter!"
        }
        else {
            
        }
        // Do any additional setup after loading the view.
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
