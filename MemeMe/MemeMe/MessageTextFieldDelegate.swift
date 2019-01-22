//
//  MessageTextFieldDelegate.swift
//  MemeMe
//
//  Created by terced-leonardoo on 20/01/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import Foundation
import UIKit

class MessageTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var initalText: String = ""
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if initalText == "" {
            initalText = textField.text!
        }
        
        if textField.text == initalText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
