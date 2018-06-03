//
//  LoginViewController.swift
//  trelloLike
//
//  Created by Marion  on 17/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    var username = ""
                    var key = ""
                    var token = ""
                    
                    let userID = Auth.auth().currentUser?.uid
                    ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let value = snapshot.value as? NSDictionary
                        if ((value?.count)! > 0){
                            username = value?["trelloUsername"] as? String ?? ""
                            key = value?["trelloKey"] as? String ?? ""
                            token = value?["trelloToken"] as? String ?? ""
                            
                            UserDefaults.standard.set(username, forKey: "trelloUsername")
                            UserDefaults.standard.set(key, forKey: "trelloKey")
                            UserDefaults.standard.set(token, forKey: "trelloToken")
                            //Go to the HomeViewController if the login is sucessful
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Boards") as! UINavigationController
                            self.present(vc, animated: true, completion: nil)
                            
                            
                        }
                        
                        
                    }) { (error) in
                        print(error.localizedDescription)
                    }

                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
