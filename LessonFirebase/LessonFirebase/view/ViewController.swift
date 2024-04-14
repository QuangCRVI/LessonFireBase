//
//  ViewController.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 12/4/24.
//

import UIKit
import Firebase


class ViewController: BaseViewController {

    @IBOutlet weak var btForgot: UIButton!
    @IBOutlet weak var btRegister: UIButton!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundCorner(views: [btLogin, btRegister, btForgot], radius: 10)
    }

    @IBAction func tapOnLogin(_ sender: UIButton) {
        view.endEditing(true)
        startAnimating()
        
        if tfEmail.text == "" {
            makeToast(string: "Please enter email!!!")
        }
        
        if tfPassword.text == "" {
            makeToast(string: "Please enter password!!!")
        }
        
        // CALL SIGN IN FUNCTION
        Auth.auth().signIn(withEmail: tfEmail.text!, password: tfPassword.text!) { result, error in
            if error != nil {
                self.makeToast(string: error!.localizedDescription)
                self.stopAnimating()
            } else {
                if let data = result {
                    print(data.user.email!)
                }
                self.stopAnimating()
                let vc = HomeVC(nibName: "HomeVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func clickedRegister(_ sender: Any) {
        let vc = RegisterVC(nibName: "RegisterVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapOnForgot(_ sender: UIButton) {
        
        let vc = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

