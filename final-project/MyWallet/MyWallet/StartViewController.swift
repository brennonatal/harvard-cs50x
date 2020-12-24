//
//  ViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 14/12/20.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "StartToHomeSegue", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }

}

