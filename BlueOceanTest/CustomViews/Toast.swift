//
//  Toast.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import UIKit

class Toast: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.height / 2.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2.0
    }
    
    func show() {
        if !self.isHidden {
            return
        }
        
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        })
        Timer.scheduledTimer(timeInterval: 2.2, target: self, selector: #selector(toastDisappear), userInfo: nil, repeats: false)
    }
    
    func show(text: String) {
        let centerX = self.center.x
        let centerY = self.center.y
        
        self.text = text
        let size = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: self.font.pointSize)])
        self.frame.size.width = size.width + 40
        self.center.x = centerX
        self.center.y = centerY
        
        show()
    }
    
    @objc private func toastDisappear() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.isHidden = true
        })
    }
    
}
