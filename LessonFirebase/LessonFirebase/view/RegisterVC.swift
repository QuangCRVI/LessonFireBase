//
//  RegisterVC.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 12/4/24.
//

import UIKit
import Toast
import NVActivityIndicatorView
import Firebase
import FirebaseAuth

class RegisterVC: BaseViewController {

    @IBOutlet weak var btRegister: UIButton!
    @IBOutlet weak var tfConfirmPass: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundCorner(views: [btRegister], radius: 10)
    }

    @IBAction func tapOnRegister(_ sender: Any) {
        view.endEditing(true)
        
        startAnimating()
        
        if tfEmail.text == "" {
            makeToast(string: "Please enter email!!!")
        }
        
        if tfPassword.text == "" {
           makeToast(string: "Please enter pass!!!")
        }
        
        if tfConfirmPass.text == "" {
            makeToast(string: "Please enter confirm password!!!")
        }
        
        if tfConfirmPass.text != tfPassword.text {
           makeToast(string: "Password not match")
        }
        
        // REGISTER USER
        Auth.auth().createUser(withEmail: tfEmail.text!, password: tfPassword.text!) { result, error in
            if error != nil { // REGISTER ERROR
                self.makeToast(string: error!.localizedDescription)
                self.stopAnimating()
            } else { // REGISTER SUCCSESS
                if let data = result {
                    let idUser = data.user.uid
                    
                    print(data.user.email ?? "")
                    print(idUser)
                    
                    // SAVE USER INFORMATION -> DATABASE
                    // POST DATA
                    let databaseReference = Database.database().reference()
                    let value = ["email": data.user.email, "id": idUser]
                    databaseReference.child("Users").child(idUser).setValue(value)
                }
                
                self.makeToast(string: "You have register sucessfully!!!")
                self.stopAnimating()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let vc = self.navigationController {
                        vc.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
