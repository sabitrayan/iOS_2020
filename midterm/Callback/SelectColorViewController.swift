//
//  SelectColorViewController.swift
//  Callback
//
//  Created by erumaru on 2/29/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class SelectColorViewController: UIViewController {
    
    var onSelect: ((UIColor) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func colorSelected(_ sender: UIButton) {
        if sender.titleLabel?.text == "Red" {
            self.onSelect?(UIColor.red)
        } else {
            self.onSelect?(UIColor.blue)
        }
        
        self.dismiss(animated: true)
    }
}
