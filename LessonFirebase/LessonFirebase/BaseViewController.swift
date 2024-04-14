//
//  BaseViewController.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 12/4/24.
//

import UIKit
import NVActivityIndicatorView
import Toast
import NVActivityIndicatorView
import Firebase

class BaseViewController: UIViewController {
    
    let viewIdicator = UIView()
    var loadingIndicator: NVActivityIndicatorView?
    
    let databaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupIndicator()
    }
    
    func setupIndicator() {
        viewIdicator.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        roundCorner(views: [viewIdicator], radius: 10)
        view.addSubview(viewIdicator)
        viewIdicator.translatesAutoresizingMaskIntoConstraints = false
        viewIdicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        viewIdicator.heightAnchor.constraint(equalToConstant: 60).isActive = true
        viewIdicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewIdicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewIdicator.isHidden = true
        
        let frame = CGRect(x: 15, y: 15, width: 30, height: 30)
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.lineScale, color: .white, padding: 0)
        viewIdicator.addSubview(loadingIndicator!)
    }
    
    func startAnimating() {
        viewIdicator.isHidden = false
        view.isUserInteractionEnabled = false
        loadingIndicator?.startAnimating()
    }
    
    func stopAnimating() {
        viewIdicator.isHidden = true
        view.isUserInteractionEnabled = true
        loadingIndicator?.startAnimating()
    }
    
    func roundCorner(views: [UIView], radius: CGFloat) {
        views.forEach { v in
            v.layer.cornerRadius = radius
            v.layer.masksToBounds = true
        }
    }
    
    func makeToast(string: String) {
        self.view.makeToast(string)
        stopAnimating()
        return
    }
}
