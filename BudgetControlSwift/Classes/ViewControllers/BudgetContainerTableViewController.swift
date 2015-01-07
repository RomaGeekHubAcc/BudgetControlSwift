//
//  BudgetContainerTableViewController.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/30/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

import UIKit

class BudgetContainerTableViewController: UITableViewController {
    // MARK: Variables
    var currentBudget: CDBudgetMonth?
    
    
    //MARK: Interface methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext!
        var date = NSDate()
        currentBudget = CDBudgetMonth.getBudget(date, context: managedObjectContext)

        self.tableView.scrollEnabled = false
        
        
    }
    
}
