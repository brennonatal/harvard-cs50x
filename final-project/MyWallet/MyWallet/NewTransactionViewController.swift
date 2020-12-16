//
//  NewTransactionViewController.swift
//  MyWallet
//
//  Created by Brenno Natal on 16/12/20.
//

import UIKit
import Firebase

class NewTransactionViewController: UIViewController /*, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate */{
    
    var userUid: String!
    
//    var selectedType: String?
//    var typeList = ["Income", "Outcome"]
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return typeList.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return typeList[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedType = typeList[row]
//        type.text = selectedType
//    }
//
//    func createPickerView() {
//           let pickerView = UIPickerView()
//           pickerView.delegate = self
//           type.inputView = pickerView
//    }
//
//    func dismissPickerView() {
//       let toolBar = UIToolbar()
//       toolBar.sizeToFit()
//       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
//       toolBar.setItems([button], animated: true)
//       toolBar.isUserInteractionEnabled = true
//       type.inputAccessoryView = toolBar
//    }
//
//    @objc func action() {
//          view.endEditing(true)
//    }
    
    @IBOutlet var name: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var type: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userUid = Auth.auth().currentUser?.uid
    }
    
    @IBAction func createTransaction() {
        if name.text == "" {
            name.text = "No name"
        }
        if type.text == "" {
            type.text = "Not provided"
        }
        
        let _ = TransactionManager.main.create(uid: userUid, name: name.text!, amount: Double(amount.text ?? "0") ?? 0, type: type.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
}
