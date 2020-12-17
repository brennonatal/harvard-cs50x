//
//  NewTransactionViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 16/12/20.
//

import UIKit
import Firebase

class NewTransactionViewController: UIViewController {
    
    var userUid: String!
    let typeData = ["Income", "Outcome"]
    
    @IBOutlet var name: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var type: UIPickerView!
    var textType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type.dataSource = self
        type.delegate = self
        userUid = Auth.auth().currentUser?.uid
    }
    
    @IBAction func createTransaction() {
        if name.text == "" {
            name.text = "No name"
        }
        let _ = TransactionManager.main.create(uid: userUid, name: name.text!, amount: Double(amount.text ?? "0") ?? 0, type: textType!)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NewTransactionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeData.count
    }
    
    
}

extension NewTransactionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        textType = typeData[row]
        return typeData[row]
    }
}
