//
//  TransactionViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 16/12/20.
//

import UIKit

class TransactionViewController: UIViewController {
    
    var transaction: Transaction!
    var typeData: [String]!
    var textType: String!
    
    @IBOutlet var name: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var type: UIPickerView!
    @IBOutlet var date: UITextField!
    
    @IBAction func deleteButton() {
        let confirmAlert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)

        confirmAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction!) in
            self.deleteTransaction()
        }))

        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              return
        }))
        
        self.present(confirmAlert, animated: true, completion: nil)
    }
    
    private func deleteTransaction() {
        TransactionManager.main.delete(transaction: transaction)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if transaction.type == "Income" {
            typeData = ["Income", "Outcome"]
        }
        else {
            typeData = ["Outcome", "Income"]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        type.dataSource = self
        type.delegate = self
        
        name.text = transaction.name
        amount.text = String(transaction.amount)
        date.text = transaction.date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        transaction.name = name.text ?? "No name"
        transaction.amount = Double(amount.text ?? "0") ?? 0
        transaction.type = textType
        TransactionManager.main.update(transaction: transaction)
    }
    
}

extension TransactionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeData.count
    }
    
    
}

extension TransactionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        textType = typeData[row]
        return typeData[row]
    }
}
