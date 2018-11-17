//
//  ViewController.swift
//  ChatNote
//
//  Created by Briandito Priambodo on 15/11/18.
//  Copyright © 2018 Briandito Priambodo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //MARK: declare instance variables
    var messageArray: [Message] = [Message]()
    
    @IBOutlet var emptyStatePrompt: UIStackView!
    @IBOutlet var emptyStateButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: set controller as delegate and datasource
        
    }


}

