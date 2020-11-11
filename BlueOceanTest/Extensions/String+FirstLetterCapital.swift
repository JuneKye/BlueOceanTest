//
//  String+FirstLetterCapital.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/08.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
