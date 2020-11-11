//
//  TableViewCellForUnsplashImage.swift
//  BlueOceanTest
//
//  Created by June Kye on 2020/11/07.
//

import UIKit

class TableViewCellForUnsplashImage: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var unsplashImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var entireDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view.layer.cornerRadius = 0.0
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 15.0
        view.layer.shadowOpacity = 0.7
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
