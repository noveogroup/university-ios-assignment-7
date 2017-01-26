//
//  ViewController.swift
//  Task_7
//
//  Created by Kirill Asyamolov on 23/12/16.
//  Copyright © 2016 Kirill Asyamolov. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate {

    private var circleCenter: CGPoint!
    private var circleAnimator: UIViewPropertyAnimator!
    
    private var initPoint: CGPoint!
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputTextView.layer.borderWidth = 1
        outputTextView.layer.borderColor = UIColor.black.cgColor
        
        let circle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        circle.center = self.view.center
        circle.layer.cornerRadius = 50
        circle.backgroundColor = UIColor.green
        
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragCircle)))
        
        initPoint = CGPoint(x: view.frame.width * 0.5, y: view.frame.height - circle.layer.cornerRadius)
        
        circle.center = initPoint
        
        addDoneButtonOnKeyboard()
        
        self.view.addSubview(circle)
    }
    
    func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        
        switch gesture.state {
        case .began:
            if circleAnimator != nil && circleAnimator!.isRunning {
                circleAnimator!.stopAnimation(false)
            }
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter!.x + translation.x, y: circleCenter!.y + translation.y)
        case .ended:
            let v = gesture.velocity(in: target)
            let velocity = CGVector(dx: v.x / 500, dy: v.y / 500)
            let springParameters = UISpringTimingParameters(mass: 2.5, stiffness: 70, damping: 55, initialVelocity: velocity)
            circleAnimator = UIViewPropertyAnimator(duration: 0, timingParameters: springParameters)
            
            circleAnimator!.addAnimations {
                target.center = self.initPoint
            }
            circleAnimator!.startAnimation()
        default: break
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        numberTextField.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        numberTextField.resignFirstResponder()
        if let text = numberTextField.text {
            if let n = Int(text) {
                startCounting(to: n)
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = numberTextField.text {
            if let n = Int(text) {
                startCounting(to: n)
            }
        }
        
        return true
    }
    
    func startCounting(to n: Int) {
        outputTextView.text = ""
        numberTextField.isEnabled = false
        
        DispatchQueue.global(qos: .utility).async {
            for i in 1..<n {
                let result = NumberGenerator.fibonacci(i)
                DispatchQueue.main.async {
                    self.outputTextView.insertText("\(i): \(result) ")
                }
            }
            
            DispatchQueue.main.async {
                self.numberTextField.isEnabled = true
            }
        }
    }

}

