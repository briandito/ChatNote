//
//  ViewController.swift
//  ChatNote
//
//  Created by Briandito Priambodo on 15/11/18.
//  Copyright © 2018 Briandito Priambodo. All rights reserved.
//

import UIKit
import KeyboardWrapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, KeyboardWrapperDelegate {

    //MARK: declare instance variables
//    var messageArray: [Message] = [Message]()

    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    var keyboardWrapper: KeyboardWrapper?

    
    //MARK: iboutlets links
    
    //textfield style
    @IBOutlet var messageTextField: UITextField! {
        didSet {
            messageTextField.layer.cornerRadius =  17
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 8.0))
            messageTextField.leftView = leftView
            messageTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardWrapper = KeyboardWrapper(delegate: self)
        
        //MARK: set controller as delegate and datasource
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //MARK: set controller as the delegate of textfield
        messageTextField.delegate = self
        
        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "newMessageCell", bundle: nil), forCellReuseIdentifier: "newMessageCell")
        
        configureTableView()
        retrieveMessages()
        
        //MARK: Table UI fixes
        messageTableView.separatorStyle = .none
    }
    
    /////////////////////////////////////
    
    //MARK: Tableview data source methods
    
    //TODO: declare cellforRowat indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMessageCell", for: indexPath) as! newMessageCell
        
        let messageArray = ["When a customer is having a haircut, some shops might have these small screens which shows ads, tv shows, or the shop's own commercial videos. How can we entertain her/him for at least 10 minutes using this small screen? How can we make the experience delightful and enjoyable in the 10 minutes window?", "ut, some shops might have these small screens which shows ads, tv shows, or the shop's own commercial videos. How can we entertain her/him for kezia balobo", "third meis small screen? How  ssage"]
        
        cell.newMessageDate.text = getDateAndTime()
        cell.newMessageBody.text = messageArray[indexPath.row]
        
        //MARK: set line height
        let paragraphStyle = NSMutableParagraphStyle()
        
        //line height size
        paragraphStyle.lineSpacing = 3
        let attrString = NSMutableAttributedString(string: cell.newMessageBody.text!)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        cell.newMessageBody.attributedText = attrString
        
        return cell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//      return messageArray.count
        return 3
    }
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK: Date and time configurator
    func getDateAndTime() -> String{
        
        var dateAndTime: String = ""
        
        // get the current date and time
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        
        // "October 8, 2016 at 10:52 PM"
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        dateAndTime = formatter.string(from: currentDateTime)
        
        return dateAndTime
    }
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    
    //TODO: Declare textFieldDidBeginEditing here:
    
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
//        //animation
//        UIView.animate(withDuration: 0.25) {
//            self.heightConstraint.constant = 308
//            self.view.layoutIfNeeded()
//        }
        
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField){
        
//        //animation
//        UIView.animate(withDuration: 0.25) {
//            self.heightConstraint.constant = 52
//            self.view.layoutIfNeeded()
//        }

    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send Message as notes
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextField.endEditing(true)
        
        let message = Message()

        message.date = getDateAndTime()
        message.messageBody = messageTextField.text!
        
        print(message.date)
        print(message.messageBody)
        
//        self.messageArray.append(message)
//        print(messageArray.last?.messageBody)
        
        messageTextField.text = ""
    }
    
    //MARK: Create the retrieveMessages method here:
    
    func retrieveMessages(){
        
        
        configureTableView()
        messageTableView.reloadData()
    }
    
    func keyboardWrapper(_ wrapper: KeyboardWrapper, didChangeKeyboardInfo info: KeyboardInfo) {
        
        if info.state == .willShow || info.state == .visible {
            heightConstraint.constant = info.endFrame.size.height + 52
        } else {
            heightConstraint.constant = 52
        }
        
        view.layoutIfNeeded()
    }
}

