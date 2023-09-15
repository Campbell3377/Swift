//
//  ViewController.swift
//  segue
//
//  Created by Janaka Balasooriya on 9/17/19.
//  Copyright © 2019 Janaka Balasooriya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data_from_second:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SecondViewController
        
        destination.data_from_first = "Hello from 1st"
    }
    
    @IBAction func fromSecond(segue: UIStoryboardSegue)
    {
        if let sourceView = segue.source as? SecondViewController {
              data_from_second = sourceView.data
              print(data_from_second)
        }
      
    }

}

