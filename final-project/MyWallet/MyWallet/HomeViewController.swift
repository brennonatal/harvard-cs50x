//
//  HomeViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 15/12/20.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {
    
    var userUid: String!
    var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userUid = Auth.auth().currentUser!.uid
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
        
        let type = transactions[indexPath.row].type
        
        if type == "Income" {
            cell.textLabel?.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }
        else {
            cell.textLabel?.textColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 1)
        }
        
        cell.textLabel?.text = "$\(transactions[indexPath.row].amount)"
        cell.detailTextLabel?.text = transactions[indexPath.row].name
//        ~~~~~~~~~~~~~~ CHANGE COLOR OF CELLS HERE ~~~~~~~~~~~~~~
        return cell
    }
    
    func reload() {
        transactions = TransactionManager.main.getUserTransactions(uid: userUid)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransactionSegue" {
            if let destination = segue.destination as? TransactionViewController {
                destination.transaction = transactions[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    @IBAction func confirmLogOut() {
        let confirmAlert = UIAlertController(title: "Confirm logout?", message: nil, preferredStyle: .alert)

        confirmAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action: UIAlertAction!) in
            self.logOut()
        }))

        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              return
        }))
        
        self.present(confirmAlert, animated: true, completion: nil)
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()

        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
        
    }
    
    // this method handles row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TransactionManager.main.delete(transaction: transactions[indexPath.row])
            reload()
        }
    }
}
