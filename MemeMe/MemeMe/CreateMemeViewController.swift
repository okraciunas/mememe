//
//  ViewController.swift
//  MemeMe
//
//  Created by terced-leonardoo on 16/01/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    private let messageTextFieldDelegate = MessageTextFieldDelegate()
    private let defaultTextAttributes: [NSAttributedString.Key : Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -3 ]
    
    // MARK - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextField(textField: topTextField, label: "TOP")
        initTextField(textField: bottomTextField, label: "BOTTOM")
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK - Keyboard observer notifications
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification:Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardRect = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0 && bottomTextField.isEditing {
            self.view.frame.origin.y -= keyboardRect.height
        }
    }
    
    @objc private func keyboardWillHide(_ notification:Notification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK - Initialize UI elements
    
    private func initTextField(textField: UITextField, label: String) {
        textField.delegate = messageTextFieldDelegate
        textField.defaultTextAttributes = defaultTextAttributes
        textField.textAlignment = .center
        textField.text = label
    }
    
    @objc private func initImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        imagePickerController.modalPresentationStyle = .popover
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imagePickerView.image = image
            self.shareButton.isEnabled = self.imagePickerView.image != nil
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    private func toolbarIsHidden(_ hidden: Bool) {
        topToolbar.isHidden = hidden
        bottomToolbar.isHidden = hidden
    }
    
    private func generateMemedImage() -> UIImage {
        toolbarIsHidden(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolbarIsHidden(false)
        
        return memedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.cancel()
    }
    
    private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK - Buttons methods
    
    @IBAction func pickAnImage(_ sender: Any) {
        initImagePickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        initImagePickerController(sourceType: .camera)
    }
    
    @IBAction func saveMemeImage(_ sender: Any) {
        let memedImage = self.generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
            
            if completed {
                let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.imagePickerView.image!, memedImage: memedImage)
                
                let object = UIApplication.shared.delegate
                let appDelegate = object as! AppDelegate
                appDelegate.memes.append(meme)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelCreateMeme(_ sender: UIBarButtonItem) {
        self.cancel()
    }
}
