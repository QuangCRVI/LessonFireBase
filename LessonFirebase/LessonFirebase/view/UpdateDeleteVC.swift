//
//  UpdateDeleteVC.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 13/4/24.
//

import UIKit
import Firebase

protocol UpdateDeleteDelegate {
    func updateUser()
    func deleteUser()
}

class UpdateDeleteVC: BaseViewController {
    
    var user: User?
    
    var delegate: UpdateDeleteDelegate?
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //view.isOpaque = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        
        if let data = user {
            tfID.text = data.id
            tfEmail.text = data.email
        }
    }
    
    @IBAction func tapOnUpdate(_ sender: UIButton) {
        
        if tfEmail.text == "" {
            self.view.makeToast("Please modify your email!!!")
            return
        }
        
        if let data = user {
            let value = ["email": tfEmail.text!]
            databaseReference.child("Users").child(data.id).updateChildValues(value)
            delegate?.updateUser()
            dismiss(animated: true)
        }
    }
    
    
    @IBAction func tapOnDelete(_ sender: Any) {
        if let data = user {
            databaseReference.child("Users").child(data.id).removeValue()
            delegate?.deleteUser()
            dismiss(animated: true)
        }
    }
}
