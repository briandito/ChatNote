//
//  ViewController.swift
//  ChatNote
//
//  Created by Briandito Priambodo on 15/11/18.
//  Copyright © 2018 Briandito Priambodo. All rights reserved.
//

import UIKit
import KeyboardWrapper
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, KeyboardWrapperDelegate {

    var keyboardWrapper: KeyboardWrapper?
    var messages: [Message] = []
    var notebook: [NSManagedObject] = []
    
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
    
    @IBOutlet var composeMessageView: UIView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Messages")
        
        //3
        do {
            notebook = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
    //MARK: Tableview data source methods
    
    //TODO: declare cellforRowat indexpath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = notebook[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMessageCell", for: indexPath) as! newMessageCell
        
        cell.newMessageBody?.text = note.value(forKeyPath: "messageBody") as? String
        cell.newMessageDate?.text = note.value(forKeyPath: "messageDate") as? String
        cell.selectionStyle = .none
        
        //Cell gesture recognizer
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        longPressGR.minimumPressDuration = 0.3 // how long before menu pops up
        cell.addGestureRecognizer(longPressGR)
        
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
      return notebook.count
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
    
    
    //MARK: - Send Message as notes
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextField.endEditing(true)
        
        let message = Message()

        message.date = getDateAndTime()
        message.messageBody = messageTextField.text!
        
        print(message.date)
        print(message.messageBody)
        
        save(date: message.date, messageBody:message.messageBody)
        messageTableView.reloadData()
        
        messageTextField.text = ""
    }
    
    //MARK: Saving message to core data
    func save(date: String, messageBody: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Messages", in: managedContext)!
        
        let messages = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3
        messages.setValue(messageBody, forKeyPath: "messageBody")
        messages.setValue(date, forKeyPath: "messageDate")
        
        //4
        do {
            try managedContext.save()
            notebook.append(messages)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    //MARK: Create the retrieveMessages method here:
    func retrieveMessages(){
        configureTableView()
        messageTableView.reloadData()
    }
    
    func keyboardWrapper(_ wrapper: KeyboardWrapper, didChangeKeyboardInfo info: KeyboardInfo) {
        
        if info.state == .willShow || info.state == .visible {

            bottomConstraint.constant = info.endFrame.size.height * -1
            
        } else {
            bottomConstraint.constant = 0
        }
        
        view.layoutIfNeeded()
    }
    
    //MARK: Cell long press handler
    @objc func longPressHandler(sender: UILongPressGestureRecognizer) {
        guard sender.state == .began,
            let senderView = sender.view,
            let superView = sender.view?.superview
            else { return }
        
        // Make responsiveView the window's first responder
        senderView.becomeFirstResponder()
        
        // Set up the shared UIMenuController
        let copyMenuItem = UIMenuItem(title: "Copy", action: #selector(copyTapped))
        let deleteMenuItem = UIMenuItem(title: "Delete", action: #selector(deleteTapped))
        UIMenuController.shared.menuItems = [copyMenuItem, deleteMenuItem]
        
        // Tell the menu controller the first responder's frame and its super view
        UIMenuController.shared.setTargetRect(senderView.frame, in: superView)
        
        // Animate the menu onto view
        UIMenuController.shared.setMenuVisible(true, animated: true)
        
        print("first responder")
    }
    
    @objc func copyTapped() {
        print("copy tapped")
        // ...
        // This would be a good place to optionally resign
        // responsiveView's first responder status if you need to
        self.resignFirstResponder()
    }
    
    @objc func deleteTapped() {
        print("delete tapped")
        // ...
        self.resignFirstResponder()
    }
}

