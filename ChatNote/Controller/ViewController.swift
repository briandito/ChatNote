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

    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    //MARK: iboutlets links
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Observe keyboard change
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
        
        //MARK: set controller as delegate and datasource
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //MARK: set controller as the delegate of textfield
        messageTextField.delegate = self
        
        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retrieveMessages()
    }
    
    /////////////////////////////////////
    
    //MARK: Tableview data source methods
    
    //TODO: declare cellforRowat indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! customMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.messageDate.text = messageArray[indexPath.row].date
        
        return cell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
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
    
    
    
    
//    func bindToKeyboard(){
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(keyboardWillShow),
//            name: UIResponder.keyboardWillShowNotification,
//            object: nil
//        )
//    }
//
//    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            heightConstraint.constant = keyboardRectangle.height
//            view.layoutIfNeeded()
//        }
//    }
//
    ///////////////////////////////////////////
    
    
    //MARK: - Send Message as notes
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextField.endEditing(true)
        
        let message = Message()

        message.date = getDateAndTime()
        message.messageBody = messageTextField.text!
        
        print(message.date)
        print(message.messageBody)
        
        self.messageArray.append(message)
        print(messageArray.last?.messageBody)
        messageTextField.text = ""
    }
    
    //MARK: Create the retrieveMessages method here:
    
    func retrieveMessages(){
        
        configureTableView()
        messageTableView.reloadData()
    }
}
