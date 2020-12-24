//
//  WalletDetailsViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 16/12/20.
//

import UIKit
import Firebase

class WalletDetailsControllerView: UIViewController {
    
    @IBOutlet var income: UILabel!
    @IBOutlet var outcome: UILabel!
    @IBOutlet var balance: UILabel!
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWalletDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reload() {
        viewWillAppear(true)
    }
    
    func setWalletDetails() {
        var userUid: String!
        var transactions: [Transaction] = []
        
        userUid = Auth.auth().currentUser!.uid
        transactions = TransactionManager.main.getUserTransactions(uid: userUid)
        
        var incomeValue: Double = 0
        var outcomeValue: Double = 0
        var totalBalance: Double = 0
        
        for t in transactions {
            print(t)
            if t.type == "Income" {
                incomeValue += t.amount
            }
            else {
                outcomeValue += t.amount
            }
        }
        
        totalBalance = incomeValue - outcomeValue
        self.income.text = "$\(incomeValue)"
        self.outcome.text = "$\(outcomeValue)"
        self.balance.text = "$\(totalBalance)"
    }
    
}
