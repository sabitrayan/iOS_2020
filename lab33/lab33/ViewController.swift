//
//  ViewController.swift
//  lab33
//
//  Created by Раян Сабит on 3/8/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(add_button))
    }
    
    @objc func figureDidTap(_ recognizer_for_xren: UITapGestureRecognizer) {
        let new_view = recognizer_for_xren.view!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Smrt = storyboard.instantiateViewController(identifier: "Smrt") as Smrt
        Smrt.SB = new_view
        navigationController?.pushViewController(Smrt, animated: true)
    }
    
    @objc func add_button(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        
        guard let Smrt = storyboard.instantiateViewController(identifier: "Smrt") as? Smrt else {return}
        self.navigationController?.pushViewController(Smrt, animated: true)
        
        Smrt.onSave = {(x,y,width,height,color) in
            let figure = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            figure.backgroundColor = color
            self.view.addSubview(figure)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.figureDidTap))
            figure.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.figureDidPan(recognizer_for_xren:)))
            figure.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.figureDidPinch))
            figure.addGestureRecognizer(pinchGestureRecognizer)
        }
    }
    
    
    var baseOrigin: CGPoint!
    @objc func figureDidPan(recognizer_for_xren: UIPanGestureRecognizer) {
        let new_view = recognizer_for_xren.view!
        let translation = recognizer_for_xren.translation(in: view)
        switch recognizer_for_xren.state {
        case .changed:
            new_view.center = CGPoint(x: new_view.center.x + translation.x, y: new_view.center.y + translation.y)
            recognizer_for_xren.setTranslation(CGPoint.zero, in: view)
        default:
            break
        }
    }
    
    @objc func figureDidPinch(_ recognizer: UIPinchGestureRecognizer) {
        recognizer.view?.transform = ((recognizer.view?.transform.scaledBy(x: recognizer.scale, y: recognizer.scale))!)
        recognizer.scale = 1
    }
    
}

