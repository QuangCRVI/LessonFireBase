//
//  ForgotPasswordVC.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 13/4/24.
//

import UIKit
import Firebase


class ForgotPasswordVC: BaseViewController {

    @IBOutlet weak var btSendPass: UIButton!
    @IBOutlet weak var tfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundCorner(views: [btSendPass], radius: 10)
    }
    
    @IBAction func tapOnSendPass(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: tfEmail.text!) { error in
            if error != nil {
                self.makeToast(string: error!.localizedDescription)
            } else {
                self.makeToast(string: "Send email sucessfully!!!")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let vc = self.navigationController {
                vc.popViewController(animated: true)
            }
        }
    }
}
