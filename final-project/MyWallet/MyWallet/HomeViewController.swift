//
//  HomeViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 15/12/20.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
