//
//  PanelAnimationController.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import UIKit

class PanelAnimationController {
    
    static func showPanel(panel: UIView) {
        panel.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            panel.subviews[0].alpha = 0.75
        }, completion: nil)
        panel.subviews[1].transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        CustomAnimation.animate(withDuration: 0.3, timingFunction: CustomAnimation.TimingFunction.BackOut, animations: {
            panel.subviews[1].transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    static func closePanel(panel: UIView, animation: Bool) {
        if !animation {
            panel.isHidden = true
            panel.subviews[1].transform = CGAffineTransform.identity
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                panel.subviews[0].alpha = 0
            }, completion: nil)
            CustomAnimation.animate(withDuration: 0.3, timingFunction: CustomAnimation.TimingFunction.BackIn, animations: {
                panel.subviews[1].transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            }, completion: {
                panel.isHidden = true
                panel.subviews[1].transform = CGAffineTransform.identity
            })
        }
    }
    
}
