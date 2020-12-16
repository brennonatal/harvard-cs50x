//
//  RegisterViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 15/12/20.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func alertMessage(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if password.text != confirmPassword.text {
            alertMessage(title: "Passwords don't match", message: nil)
        }
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "RegisterToHomeSegue", sender: self)
                }
                else {
                    self.alertMessage(title: "Error", message: error?.localizedDescription)
                }
            }
            
        }

    }
    

}
