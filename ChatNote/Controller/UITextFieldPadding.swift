//
//  UITextFieldPadding.swift
//  ChatNote
//
//  Created by Briandito Priambodo on 25/11/18.
//  Copyright © 2018 Briandito Priambodo. All rights reserved.
//

import UIKit

class UITextFieldPadding: UITextField {

        
    let padding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect.insetBy(dx:10,dy:10)
        }
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect.insetBy(dx:10,dy:10)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect.insetBy(dx:10,dy:10)
        }

}
