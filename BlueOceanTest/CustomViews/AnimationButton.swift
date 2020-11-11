//
//  AnimationButton.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import UIKit

class AnimationButton: UIButton {
    private var frameRect: CGRect?
    private var clickable = false
    private var isLeftCircleOn = false
    private var isLeftCircleCreated = false
    private var offsetXForLeftCircle: CGFloat?
    private var colorForLeftCircle: UIColor?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isLeftCircleOn && !isLeftCircleCreated {
            self.createLeftCircle(offsetX: offsetXForLeftCircle, color: colorForLeftCircle)
        }
    }
    
    @IBInspectable var leftCircleOn: Bool {
        get {
            return isLeftCircleOn
        }
        set {
            isLeftCircleOn = newValue
        }
    }
    
    @IBInspectable var offsetX: CGFloat {
        get {
            return offsetXForLeftCircle!
        }
        set {
            offsetXForLeftCircle = newValue
        }
    }
    
    @IBInspectable var leftCircleColor: UIColor {
        get {
            return colorForLeftCircle!
        }
        set {
            colorForLeftCircle = newValue
        }
    }
    
    func createLeftCircle(offsetX: CGFloat?, color: UIColor?) {
        let circle: UIView
        if offsetX == nil {
            circle = UIView.init(frame: CGRect.init(x: 10, y: 0, width: 20, height: 20))
        } else {
            circle = UIView.init(frame: CGRect.init(x: offsetX!, y: 0, width: 20, height: 20))
        }
        circle.layer.cornerRadius = 10
        circle.layer.borderWidth = 1
        circle.layer.borderColor = UIColor.init(red: (100.0 / 255.0), green: (100.0 / 255.0), blue: (100.0 / 255.0), alpha: 1.0).cgColor
        circle.backgroundColor = (color != nil) ? color : UIColor.clear
        circle.center = CGPoint.init(x: circle.center.x, y: self.frame.height / 2.0)
        self.addSubview(circle)
        isLeftCircleCreated = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        frameRect = self.frame
        clickable = true
        UIView.animate(withDuration: 0.25, delay: 0, options: .beginFromCurrentState, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        }, completion: nil)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = event!.allTouches!.first
        let point = touch!.location(in: self)
        if !self.rectContainsPoint(rect: frameRect!, point: point) {
            if !clickable {
                return
            }
            
            clickable = false
            UIView.animate(withDuration: 0.25, delay: 0, options: .beginFromCurrentState, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if clickable {
            self.sendActions(for: .touchUpInside)
            self.layer .removeAllAnimations()
            self.transform = CGAffineTransform.identity
            clickable = false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.layer .removeAllAnimations()
        self.transform = CGAffineTransform.identity
        clickable = false
    }
    
    private func rectContainsPoint(rect: CGRect, point: CGPoint) -> Bool {
        if -50 <= point.x && point.x <= rect.size.width + 50 {
            if -50 <= point.y && point.y <= rect.size.height + 50 {
                return true
            }
        }
        return false
    }
    
}
