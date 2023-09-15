//
//  SecondViewController.swift
//  segue
//
//  Created by Janaka Balasooriya on 9/17/19.
//  Copyright © 2019 Janaka Balasooriya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var data_from_first:String?
    var data = "Hello  from second"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(data_from_first)
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
