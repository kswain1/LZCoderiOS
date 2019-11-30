//
//  ProfileViewController.swift
//  LZCoder
//
//  Created by Dhanesh Gosai on 22/08/19.
//  Copyright © 2019 kehlin swain. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    var authUI: FUIAuth!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authUI = FUIAuth.defaultAuthUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentuser = authUI.auth?.currentUser
        if  currentuser!.isAnonymous {
            self.btnLogout.setTitle("Sign Up", for: .normal)
        } else {
            self.btnLogout.setTitle("Logout", for: .normal)
        }
        
    }
    @IBAction func btnLogoutClicked(_ sender: Any) {
        do {
            
            try authUI!.signOut()
            print("^^ Successfully signed out")
            goToLoginScreen()
        } catch {
            print("** ERROR: Couldn't sign out")
        }
    }
    
    func goToLoginScreen() {
           let appDelegate = UIApplication.shared.delegate as? AppDelegate
           if let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthNavigationController") as? UINavigationController {
               appDelegate?.window?.rootViewController = tabBarVC
           }
       }
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
        if sender == self.btnMale {
            self.btnMale.backgroundColor = UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)
            self.btnFemale.backgroundColor = .white
        } else {
            self.btnFemale.backgroundColor = UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)
            self.btnMale.backgroundColor = .white
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
