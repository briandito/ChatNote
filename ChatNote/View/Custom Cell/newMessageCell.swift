//
//  newMessageCell.swift
//  ChatNote
//
//  Created by Briandito Priambodo on 25/11/18.
//  Copyright © 2018 Briandito Priambodo. All rights reserved.
//

import UIKit

class newMessageCell: UITableViewCell {
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    @IBOutlet var newMessageBody: UILabel!
    
    @IBOutlet var newMessageDate: UILabel!
    
    @IBOutlet var newMessageBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted == true {
            // cell tapped
            isHighlighted()
        } else {
            // cell not tapped
            isNotHighlighted()
        }
    }
    
    //change message BG to highlighted color
    func isHighlighted(){
        self.newMessageBackground.backgroundColor = UIColor(red:0/255, green:122/255, blue:255/255, alpha: 0.05)
        self.newMessageBackground.layer.borderWidth = 1
        self.newMessageBackground.layer.borderColor = UIColor(red:0/255, green:122/255, blue:255/255, alpha: 1).cgColor
    }
    
    //change message BG to default color
    func isNotHighlighted(){
        self.newMessageBackground.backgroundColor = UIColor(red:235/255, green:235/255, blue:235/255, alpha: 0.5)
        self.newMessageBackground.layer.borderWidth = 0
    }
    
}
