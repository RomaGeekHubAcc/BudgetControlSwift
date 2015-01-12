//
//  AddExpenseViewController.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/10/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UITextViewDelegate,
    UITextFieldDelegate,
    UIAlertViewDelegate {
    
    //MARK: Variables:
    var categories: NSArray = []
    var currentBudget: CDBudgetMonth?
    var budgetMoney: Double = 0.00
    var expenses: Double = 0.00
    var availableMoney: Double = 0.00
    var prise: Double = 0.00
    let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext!
    var choosenCategoryIndex: Int?
    
    //MARK: Outlets:
    @IBOutlet weak var priseTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK: Interfase methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manObjContext = CoreDataManager.sharedInstance.managedObjectContext!;
        let nType:NSNumber = NSNumber(integer: EntryType.EntryTypeExpense.rawValue);
        categories = CDEntryCategory.getAllCategries(nType, context: manObjContext);

        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        priseTextField.delegate = self
        descriptionTextView.delegate = self
        
        var date = NSDate()
        currentBudget = CDBudgetMonth.getBudget(date, context: managedObjectContext)
        self.recalculateBudget()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.recalculateBudget()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    
    //MARK: Action methods
    @IBAction func save(sender: AnyObject) {
        self.view.endEditing(true)
        var isAvailable: Bool = currentBudget!.isAvailableExpense(prise)
        if  isAvailable {
            var choosenCategory: CDEntryCategory?
            if choosenCategoryIndex == nil {
                choosenCategory = CDEntryCategory.getCategory("General",
                    iconName: nil,
                    type: NSNumber(integer: EntryType.EntryTypeExpense.rawValue), 
                    context: managedObjectContext)
            } else {
                choosenCategory = categories[choosenCategoryIndex!] as? CDEntryCategory
            }
            
            var newEntry: CDEntry = CDEntry.createEntry(
                NSDate(),
                categoryName: choosenCategory!.cName,
                categoryType:NSNumber(integer: EntryType.EntryTypeExpense.rawValue),
                entryDescription: descriptionTextView.text == "Input description" ? "" : descriptionTextView.text,
                money: NSDecimalNumber(double: prise),
                checkAddress: "",
                context: managedObjectContext)
            
//            var alertView: UIAlertView = UIAlertView(title: "New Expense added",
//                message: "prise = \(prise)",
//                delegate: self,
//                cancelButtonTitle: "OK",
//                otherButtonTitles: "",
//                nil)
        }
    }
    
    
    //MARK: Delegated methods:
    
    //MARK: — UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCollectionViewCell", forIndexPath: indexPath) as CategoryCollectionViewCell

        var currCategory: CDEntryCategory = categories[indexPath.row] as CDEntryCategory
        cell.iconImageView.image = UIImage(named: currCategory.cIconName)
        cell.categoryNameLabel.text = currCategory.cName
        
        return cell
    }
    
    
    //MARK: — UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        choosenCategoryIndex = indexPath.row
    }
    
    //MARK: —UITextViewDelegate
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        if textView.text == "Input description" {
            textView.text = ""
        }
        textView.textColor = UIColor.blackColor()
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Input description"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    //MARK: —UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if  prise > 0 {
            textField.text = "\(prise)"
        }
        
        return true;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        prise = (textField.text as NSString).doubleValue;
        textField.text = "\(prise) \(currentBudget!.currency)";
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    //MARK: Private methods
    private func recalculateBudget() {
        budgetMoney = currentBudget!.calculationAllEntriesWithType(EntryType.EntryTypeIncome.rawValue).doubleValue
        expenses = currentBudget!.calculationAllEntriesWithType(EntryType.EntryTypeExpense.rawValue).doubleValue
        availableMoney = budgetMoney - expenses
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
