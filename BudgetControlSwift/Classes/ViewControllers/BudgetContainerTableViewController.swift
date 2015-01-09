//
//  BudgetContainerTableViewController.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/30/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreData

class BudgetContainerTableViewController: UITableViewController {
    
    // MARK: Variables:
    var currentBudget: CDBudgetMonth?
    
    var budgetMoney: Double = 0.00
    var expenses: Double = 0.00
    var availableMoney: Double = 0.00
    
    //MARK: Outlets:
    @IBOutlet weak var budgetCountLabel: UILabel!
    @IBOutlet weak var expensesCountLabel: UILabel!
    @IBOutlet weak var availabelMoneyLabel: UILabel!
    
    
    //MARK: Interface methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.scrollEnabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext!
        var date = NSDate()
        currentBudget = CDBudgetMonth.getBudget(date, context: managedObjectContext)
        
        budgetMoney = currentBudget!.calculationAllEntriesWithType(EntryType.EntryTypeIncome.rawValue).doubleValue
        expenses = currentBudget!.calculationAllEntriesWithType(EntryType.EntryTypeExpense.rawValue).doubleValue
        availableMoney = budgetMoney - expenses
        
        budgetCountLabel.text = "\(budgetMoney) \(currentBudget!.currency)"
        expensesCountLabel.text = "\(expenses) \(currentBudget!.currency)"
        availabelMoneyLabel.text = "\(availableMoney) \(currentBudget!.currency)"
    }
    
}
