//
//  AddExpenseViewController.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/10/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var priseTextField: UITextField!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK: Interfase methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Action methods
    @IBAction func save(sender: AnyObject) {
        
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
