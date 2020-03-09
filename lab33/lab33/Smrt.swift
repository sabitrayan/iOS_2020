//
//  Smrt.swift
//  lab33
//
//  Created by Раян Сабит on 3/8/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class Smrt: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        XY()
    }
   
    var color: UIColor?
    var SB: UIView?
    
    func XY(){
        guard let figure = SB else {return}
        print(figure.frame.width)
        self.width.text = figure.frame.width.description
        self.height.text = figure.frame.height.description
        self.x.text = figure.frame.origin.x.description
        self.y.text = figure.frame.origin.y.description
    }
    
    @IBAction func ChooseColor(_ sender: UIButton) {
        sender.isSelected = true;
        guard let backgroundColor = sender.backgroundColor else {return}
        color=backgroundColor
    }
    
    var onSave:((CGFloat,CGFloat,CGFloat,CGFloat,UIColor)-> Void)? = nil
    
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var x: UITextField!
    @IBOutlet weak var y: UITextField!
    
    @IBAction func SaveButton(_ sender: Any) {
        guard   let width_text=width.text,
                let double_width = Double(width_text),
            
                let height_text=height.text,
                let double_height = Double(height_text),

                let x_text=x.text,
                let double_x = Double(x_text),
            
                let selectedColor = self.color,
            
                let y_text=y.text,
                let double_y = Double(y_text)
        else {
            let alert = UIAlertController(title: "Sorry Bratan", message: "Zapolni vse",  preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click Me BRO", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        if CGFloat(double_width) > screenWidth || CGFloat(double_height) > screenHeight || CGFloat(double_x) > screenWidth || CGFloat(double_y) > screenHeight {
            let alert = UIAlertController(title: "Sorry Bratan", message: "Уменьши данные", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click Me BRO", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        guard SB != nil else {
            onSave?(CGFloat(double_x), CGFloat(double_y), CGFloat(double_width), CGFloat(double_height), selectedColor)

            self.navigationController?.popViewController(animated: true)
            print("Second one")
            print((CGFloat(double_x), CGFloat(double_y), CGFloat(double_width), CGFloat(double_height), selectedColor))
            return
        }
        
        SB?.backgroundColor = color
        SB?.frame = CGRect(x: CGFloat(double_x), y: CGFloat(double_y), width: CGFloat(double_width), height: CGFloat(double_height))
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Delete_Button(_ sender: UIButton) {
        guard let i = SB else {return}
        i.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
}
