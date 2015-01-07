//
//  AddEntryViewController.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/6/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//

import CoreData
import UIKit
import Foundation

class AddEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: variables
    var entryType: NSInteger?
    var categories: [AnyObject]?
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var chooseCategoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    
    
    //MARK: Interfase methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manObjContext = CoreDataManager.sharedInstance.managedObjectContext
        let nType:NSNumber = NSNumber(integer: entryType!)
        categories = CDEntryCategory.getAllCategries(nType, context: manObjContext!)
        
        moneyTextField.delegate = self
        chooseCategoryTextField.delegate = self
        descriptionTextView.delegate = self
        
//        categoryPickerView.delegate = self
//        categoryPickerView.dataSource = self
    }
    
     override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        
    }

    
    //MARK: Action methods
    @IBAction func cancel(sender: AnyObject) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addEntry(sender: AnyObject) {
        
    }
    
    
    //MARK: Delegated methods - UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if  textField.tag == 1 {
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //MARK: Delegated methods - UITextViewDelegate
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView.text == "category description" {
            textView.text = ""
        }
        textView.textColor = UIColor.blackColor()
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "category description"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }

}
