//
//  HomeViewController.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/30/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    //MARK: Interfase methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action methods

    @IBAction func addIncome(sender: AnyObject) {
        var addIncomeVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddEntryViewController") as AddEntryViewController
        addIncomeVC.entryType = EntryType.EntryTypeIncome.rawValue
        addIncomeVC.title = "Add Income"
        addIncomeVC.currensy = "UAH";
        
        let navController: UINavigationController = UINavigationController(rootViewController: addIncomeVC)
        navController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    @IBAction func addExpense(sender: AnyObject) {
        var addExpenseVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddEntryViewController") as AddEntryViewController
        addExpenseVC.entryType = EntryType.EntryTypeExpense.rawValue
        addExpenseVC.title = "Add Expense"
        addExpenseVC.currensy = "UAH";
        
        let navController: UINavigationController = UINavigationController(rootViewController: addExpenseVC)
        navController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    
    

}
