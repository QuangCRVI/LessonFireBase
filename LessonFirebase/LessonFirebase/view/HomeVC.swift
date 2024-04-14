//
//  HomeVC.swift
//  LessonFirebase
//
//  Created by Quang Nguyen on 13/4/24.
//

import UIKit
import Firebase

class HomeVC: BaseViewController {
    @IBOutlet weak var btLogout: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTableView()
        getDataFromFireBase()
    }
    
    var arrayUser = [User]()
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "userCell")
    }
    
    func getDataFromFireBase() {
        startAnimating()
        // GET
        databaseReference.child("Users").observe(.childAdded) { snapshot in
            self.databaseReference.child("Users").child(snapshot.key).observe(.value) { data in
                dump(data.value)
                if let dict = data.value as? [String: Any] {
                    let user = User(dict: dict)
                    self.arrayUser.append(user)
                    self.stopAnimating()
                    self.tableView.reloadData()
                    self.databaseReference.child("Users").child(snapshot.key).removeAllObservers()
                }
            }
        }
    }
    
    @IBAction func tapOnLogOut(_ sender: UIButton) {
        try? Auth.auth().signOut() //logout
        if let vc = self.navigationController {
            vc.popViewController(animated: true)
        }
    }
    
}
extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserCell
        let user = arrayUser[indexPath.row]
        cell.lbTitle.text = user.id
        cell.lbSub.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UpdateDeleteVC(nibName: "UpdateDeleteVC", bundle: nil)
        vc.user = arrayUser[indexPath.row]
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeVC: UpdateDeleteDelegate {
    func updateUser() {
        arrayUser.removeAll()
        tableView.reloadData()
        getDataFromFireBase()
    }
    
    func deleteUser() {
        arrayUser.removeAll()
        tableView.reloadData()
        getDataFromFireBase()
    }
}
