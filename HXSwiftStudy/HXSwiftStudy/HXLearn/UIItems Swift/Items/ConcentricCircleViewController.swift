//
//  ConcentricCircleViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/2.
//

import UIKit

class ConcentricCircleViewController: UIViewController {
    var textField: UITextField?
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Conncentric Cricle"
        textField = UITextField(frame: CGRect(x: 80, y: -20, width: 240, height: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField?.borderStyle = .roundedRect
        textField?.placeholder = "Hypnotize me"
        textField?.returnKeyType = .done
        textField?.delegate = self

        view.backgroundColor = UIColor.white
        let circle = ConcentricCircle(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        view.addSubview(circle)
        view.addSubview(self.textField!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.0, options: .curveLinear) {
            self.textField?.frame = CGRect(x: 80, y: 70, width: 240, height: 30)
        }
    }
}

//TODO: -UITextView Delegate
extension ConcentricCircleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        drawMessage(message: textField.text ?? "")
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
    
    func drawMessage(message: String) -> Void {
        for _ in 0..<20 {
            let messagelabel = UILabel()
            
            messagelabel.backgroundColor = UIColor.clear
            messagelabel.textColor = UIColor.black
            messagelabel.text = message
            messagelabel.sizeToFit()
            
            let width = self.view.bounds.size.width - messagelabel.bounds.size.width
            let x = arc4random() % UInt32(width)
            
            let height = self.view.bounds.size.height - messagelabel.bounds.size.height
            let y = arc4random() % UInt32(height)
            
            var frame = messagelabel.frame
            frame.origin = CGPoint(x: Int(x), y: Int(y))
            messagelabel.frame = frame
            
            view.addSubview(messagelabel)
            
            messagelabel.alpha = 0.0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
                messagelabel.alpha = 1.0
            }
            
            UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: .calculationModeLinear) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8) {
                    messagelabel.center = self.view.center
                }
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 1.0) {
                    let x = arc4random() % UInt32(width)
                    let y = arc4random() % UInt32(height)
                    messagelabel.center = CGPoint(x: Int(x), y: Int(y))
                }
            }
            var motionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = (-25)
            motionEffect.maximumRelativeValue = (25)
            messagelabel.addMotionEffect(motionEffect)
            
            motionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongHorizontalAxis)
            motionEffect.minimumRelativeValue = (-25)
            motionEffect.maximumRelativeValue = (25)
            messagelabel.addMotionEffect(motionEffect)
        }
    }
}

//TODO: -Helper Class
extension ConcentricCircleViewController {
    class ConcentricCircle: UIView {
        var circleColor: UIColor?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = UIColor.clear
            circleColor = UIColor.lightGray
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            let center: CGPoint = CGPoint(x: self.bounds.origin.x + self.bounds.size.width / 2.0, y: self.bounds.origin.y + self.bounds.size.height / 2.0)
            let maxRadius = hypotf(Float(self.bounds.size.height), Float(self.bounds.size.height)) / 2.0
            
            let path = UIBezierPath()
            
            var currentRadius: CGFloat = CGFloat(maxRadius)
            
            while currentRadius > 0 {
                path.move(to: CGPoint(x: center.x + CGFloat(currentRadius), y: center.y))
                path.addArc(withCenter: center, radius: currentRadius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
                currentRadius -= 20
            }
 
            path.lineWidth = 10
            circleColor?.setStroke()
            path.stroke()
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let red: CGFloat = CGFloat((arc4random() % 100)) / 100.0
            let green: CGFloat = CGFloat((arc4random() % 100)) / 100.0
            let blue: CGFloat = CGFloat((arc4random() % 100)) / 100.0
            
            circleColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
            
            setNeedsDisplay()
        }
    }
}
