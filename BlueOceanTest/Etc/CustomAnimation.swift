//
//  CustomAnimation.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import UIKit

class CustomAnimation {
    
    enum TimingFunction {
        case BackIn
        case BackOut
    }
    
    static func animate(withDuration: TimeInterval, timingFunction: TimingFunction, animations: @escaping (() -> Void), completion: (() -> Void)?) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(withDuration)
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(functionWithType(timingFunction: timingFunction))
        CATransaction.setCompletionBlock(completion)
        
        animations()
        
        CATransaction.commit()
        UIView.commitAnimations()
    }
    
    static func functionWithType(timingFunction: TimingFunction) -> CAMediaTimingFunction {
        switch (timingFunction) {
            case TimingFunction.BackIn:
                return CAMediaTimingFunction.init(controlPoints: 0.77, -0.63, 1, 1)
            case TimingFunction.BackOut:
                return CAMediaTimingFunction.init(controlPoints: 0, 0, 0.23, 1.37)
        }
    }
    
}
