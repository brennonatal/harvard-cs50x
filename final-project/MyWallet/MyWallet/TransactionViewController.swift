//
//  TransactionViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 16/12/20.
//

import UIKit

class TransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    var transaction: Transaction!
    
    var selectedType: String?
    var typeList = ["Income", "Outcome"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = typeList[row]
        type.text = selectedType
    }
    
    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           type.inputView = pickerView
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       type.inputAccessoryView = toolBar
    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    @IBOutlet var name: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var type: UITextField!
    @IBOutlet var date: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = transaction.name
        amount.text = String(transaction.amount)
        type.text = transaction.type
        date.text = transaction.date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        transaction.name = name.text ?? "No name"
        transaction.amount = Double(amount.text ?? "0") ?? 0
        transaction.type = type.text!
        
        TransactionManager.main.update(transaction: transaction)
    }
    
}
