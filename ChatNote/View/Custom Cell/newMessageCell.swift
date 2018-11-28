//
//  newMessageCell.swift
//  ChatNote
//
//  Created by Briandito Priambodo on 25/11/18.
//  Copyright © 2018 Briandito Priambodo. All rights reserved.
//

import UIKit

class newMessageCell: UITableViewCell {
    @IBOutlet var newMessageBody: UILabel!
    
    @IBOutlet var newMessageDate: UILabel!
    
    @IBOutlet var newMessageBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set bg color of the notes
        newMessageBackground.layer.borderWidth = 1
        newMessageBackground.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 0.5).cgColor

    }
    
}
