//
//  TouchTrackerViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/3.
//

import UIKit

class TouchTrackerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TouchTracker"
        view = TouchView(frame: .zero)
    }
}

//TODO: - Helper Class
extension TouchTrackerViewController {
    class TouchView: UIView, UIGestureRecognizerDelegate {
        var moveRecognizer = UIPanGestureRecognizer()
        var linesProgress: Dictionary<NSValue, Line> = [:]
        var finishedLines = [Line]()
        var selectedLine: Line? = nil
        override var canBecomeFirstResponder: Bool {
            return true
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .gray
            isMultipleTouchEnabled = true
            
            let doubleTaprecognizer = UITapGestureRecognizer(target: self, action: #selector(doubletap(gr:)))
            
            doubleTaprecognizer.numberOfTapsRequired = 2
            doubleTaprecognizer.delaysTouchesBegan = true
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(gr:)))
            
            tapRecognizer.require(toFail: doubleTaprecognizer)
            tapRecognizer.delaysTouchesBegan = true
            
            let pressPecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gr:)))
            
            moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveLine(gr:)))
            moveRecognizer.delegate = self
            moveRecognizer.cancelsTouchesInView = false
            
            addGestureRecognizer(doubleTaprecognizer)
            addGestureRecognizer(tapRecognizer)
            addGestureRecognizer(pressPecognizer)
            addGestureRecognizer(moveRecognizer)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc
        func moveLine(gr: UIPanGestureRecognizer) {
            guard let selectedLine = selectedLine, var begin = selectedLine.begin, var end = selectedLine.end else { return }
            
            let menuController = UIMenuController.shared
            if menuController.isMenuVisible {
                return
            }
            print("\(gr.state)")
            
            if gr.state == .changed {
                let translation = gr.translation(in: self)

                begin.x += translation.x
                begin.y += translation.y
                end.x += translation.x
                end.y += translation.y
                
                selectedLine.begin = begin
                selectedLine.end = end
                
                setNeedsDisplay()
                
                gr.setTranslation(.zero, in: self)
            }
        }
        
        @objc
        func longPress(gr: UIGestureRecognizer) {
            print("longpress")
            
            if gr.state == .began {
                let point = gr.location(in: self)
                selectedLine = self.lineAtPoint(p: point)
                
                if (selectedLine != nil) {
                    linesProgress.removeAll()
                }
            }
            else if gr.state == .ended {
                selectedLine = nil
            }
            setNeedsDisplay()
        }
        
        @objc
        func doubletap(gr: UIGestureRecognizer) {
            print("double tap")
            
            linesProgress.removeAll()
            finishedLines.removeAll()
            setNeedsDisplay()
        }
        
        @objc
        func tap(gr: UIGestureRecognizer) {
            print("recognizer me")
            
            let point = gr.location(in: self)
            selectedLine = self.lineAtPoint(p: point)
            
            if (selectedLine != nil) {
                becomeFirstResponder()
                
                let menu = UIMenuController.shared
                menu.arrowDirection = .default
                
                let deleteItem = UIMenuItem(title: "Delete", action: #selector(deleteLine))
                menu.menuItems = [deleteItem]
             
                menu.showMenu(from: self, rect: CGRect(x: point.x, y: point.y, width: 2, height: 2))
            }
            else {
                UIMenuController.shared.hideMenu(from: self)
            }
            setNeedsDisplay()
        }
        
        @objc
        func deleteLine() {
            for (index,line) in finishedLines.enumerated() {
                if line.begin == selectedLine?.begin,line.end == selectedLine?.end {
                    finishedLines.remove(at: index)
                    selectedLine = nil
                    print("delete")
                    setNeedsDisplay()
                    return
                }
            }
        }
        
        func lineAtPoint(p: CGPoint) -> Line? {
            for l in finishedLines {
                guard let start = l.begin, let end = l.end else { return nil }
                
                var t: CGFloat = 0.0
                while t <= 1.0 {
                    let x = CGFloat(start.x) + t * (CGFloat(end.x) - CGFloat(start.x))
                    let y = CGFloat(start.y) + t * (CGFloat(end.y) - CGFloat(start.y))
                    
                    if hypot(x - p.x, y - p.y) < 20.0 {
                        return l
                    }
                    t += 0.05
                }
            }
            return nil
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            selectedLine = nil
            UIMenuController.shared.hideMenu()
            print("touchbegan")
            
            for t in touches {
                let location = t.location(in: self)
                
                let line = Line()
                line.begin = location
                line.end = location
                
                let key = NSValue.init(nonretainedObject: t)
                linesProgress[key] = line
            }
            setNeedsDisplay()
        }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            selectedLine = nil
            UIMenuController.shared.hideMenu()
            
            print("touchmoved")
            
            for t in touches {
                let key = NSValue.init(nonretainedObject: t)
                let line = linesProgress[key]
                
                line?.end = t.location(in: self)
            }
            setNeedsDisplay()
            
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("touchended")
            
            for t in touches {
                let key = NSValue.init(nonretainedObject: t)
                let line = linesProgress[key]
                
                finishedLines.append(line!)
                linesProgress.removeValue(forKey: key)
            }
            setNeedsDisplay()
        }
        
        func strokeLine(line: Line!) {
            let bp = UIBezierPath()
            bp.lineWidth = 10
            bp.lineCapStyle = .round
            
            bp.move(to: line.begin ?? CGPoint(x: 0,y: 0))
            bp.addLine(to: line.end ?? CGPoint(x: 0, y: 0))
            bp.stroke()
        }
        
        override func draw(_ rect: CGRect) {
            UIColor.black.set()
            for line in finishedLines {
                strokeLine(line: line)
            }
            
            UIColor.red.set()
            for key in linesProgress.keys {
                strokeLine(line: linesProgress[key]!)
            }
            
            if selectedLine != nil {
                UIColor.green.set()
                strokeLine(line: selectedLine!)
            }
        }
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            if gestureRecognizer == self.moveRecognizer {
                return true
            }
            return false
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            print("touchcancelled")
            
            for t in touches {
                let key = NSValue.init(nonretainedObject: t)
                linesProgress.removeValue(forKey: key)
            }
            setNeedsDisplay()
        }
    }
    
    class Line: NSObject {
        var begin: CGPoint?
        var end: CGPoint?
    }
}
