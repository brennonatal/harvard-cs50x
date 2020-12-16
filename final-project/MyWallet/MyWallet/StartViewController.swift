//
//  ViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 14/12/20.
//

import UIKit
import Firebase

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "StartToHomeSegue", sender: nil)
        }
    }

}

