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

class AddEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: variables
    var entryType: NSInteger?;
    var currensy: String = "";
    var categories: [AnyObject] = [];
    var isCategSelecting: Bool = false;
    var prise: Double = 0.0;
    
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var chooseCategoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    
    
    //MARK: Interfase methods
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let manObjContext = CoreDataManager.sharedInstance.managedObjectContext!;
        let nType:NSNumber = NSNumber(integer: entryType!);
        categories = CDEntryCategory.getAllCategries(nType, context: manObjContext);
        
        moneyTextField.placeholder = "0.00 \(currensy)"
        
        moneyTextField.delegate = self;
        chooseCategoryTextField.delegate = self;
        descriptionTextView.delegate = self;
        
        categoryPickerView.delegate = self;
        categoryPickerView.dataSource = self;
        categoryPickerView.backgroundColor = UIColor.lightGrayColor()
        categoryPickerView.hidden = true;
    }
    
     override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
        categoryPickerView.hidden = true;
        isCategSelecting = false;
        
    }

    
    //MARK: Action methods
    @IBAction func cancel(sender: AnyObject) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addEntry(sender: AnyObject) {
        self.hideKeyboardAndPicker();
        
        if  self.checkFillAllFields() {
            let currDate = NSDate()
            let moContext: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext!
            let currBudget: CDBudgetMonth = CDBudgetMonth.getBudget(NSDate(), context: moContext)
            
            if  self.entryType == EntryType.EntryTypeIncome.rawValue {
                var newEntry: CDEntry = CDEntry.createEntry(
                    currDate,
                    categoryName: chooseCategoryTextField.text,
                    categoryType:NSNumber(integer: EntryType.EntryTypeIncome.rawValue),
                    entryDescription: descriptionTextView.text, money: NSDecimalNumber(double: prise),
                    checkAddress: "",
                    context: moContext)
            } else if self.entryType == EntryType.EntryTypeExpense.rawValue {
                var isAvailable: Bool = currBudget.isAvailableExpense(prise)
                if  isAvailable {
                    var newEntry: CDEntry = CDEntry.createEntry(
                        currDate,
                        categoryName: chooseCategoryTextField.text,
                        categoryType:NSNumber(integer: EntryType.EntryTypeExpense.rawValue),
                        entryDescription: descriptionTextView.text, money: NSDecimalNumber(double: prise),
                        checkAddress: "",
                        context: moContext)
                }
                
            } else {
                println("--- Error!!! UndefinedEntryType")
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            println("--- Fill all required fields! (Show alert later)")
        }
        
    }
    
    
    //MARK: Delegated methods:
    
    //MARK: — UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if  textField.tag == 1 {
            self.view.endEditing(true);
            
            if textField.text == "" {
                var choosenCategory: CDEntryCategory = categories[0] as CDEntryCategory;
                textField.text = choosenCategory.cName;
            }
            
            if  !isCategSelecting {
                categoryPickerView.hidden = false;
                
            } else {
                categoryPickerView.hidden = true;
            }
            
            isCategSelecting = !isCategSelecting;
            
            return false;
        } else {
            if  !categoryPickerView.hidden {
                isCategSelecting = false;
                categoryPickerView.hidden = true;
            }
            
            if  prise > 0 {
                textField.text = "\(prise)"
            }
        }
        
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 0 {
            prise = (textField.text as NSString).doubleValue;
            textField.text = "\(prise) \(currensy)";
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //MARK:  —UITextViewDelegate
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        if  !categoryPickerView.hidden {
            categoryPickerView.hidden = true;
            isCategSelecting = false;
        }
        
        if textView.text == "Entry description" {
            textView.text = ""
        }
        textView.textColor = UIColor.blackColor()
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Entry description"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    //MARK: — UIPickerViewDataSouce
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    //MARK: — UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var currCategory:CDEntryCategory = categories[row] as CDEntryCategory
        
        var pickerView = CategoryPickerView.init();
        var pickerViewFrame = CGRect(x: 20, y: 300, width: 280, height: 40);
        pickerView.viewWithFrame(pickerViewFrame, name: currCategory.cName, iconName: currCategory.cIconName);
        
        return pickerView
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var choosenCategory: CDEntryCategory = categories[row] as CDEntryCategory;
        chooseCategoryTextField.text = choosenCategory.cName;
    }
    
    
    //MARK: Private methods
    func checkFillAllFields() -> Bool {
        
        if  countElements(moneyTextField.text) == 0 {
            return false;
        }
        if  countElements(chooseCategoryTextField.text) == 0 {
            return false;
        }
        
        return true;
    }
    
    func hideKeyboardAndPicker() {
        moneyTextField.resignFirstResponder();
        descriptionTextView.resignFirstResponder();
        categoryPickerView.hidden = true;
    }
    
}



