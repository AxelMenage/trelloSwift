//
//  CompleteProfileViewController.swift
//  trelloLike
//
//  Created by Marion  on 17/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CompleteProfileViewController: UIViewController {
    
    @IBOutlet weak var trelloUsernameTextField: UITextField!
    
    @IBOutlet weak var trelloKeyTextField: UITextField!
    
    @IBOutlet weak var trelloTokenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func completeProfileAction(_ sender: Any) {
        if trelloUsernameTextField.text != "" && trelloKeyTextField.text != "" && trelloTokenTextField.text != ""{
            let userID = Auth.auth().currentUser?.uid
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("users").child(userID!).setValue(["trelloUsername": trelloUsernameTextField.text, "trelloKey": trelloKeyTextField.text, "trelloToken": trelloTokenTextField.text])
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Boards")
            self.present(vc!, animated: true, completion: nil)

        }else{
            let alertController = UIAlertController(title: "Error", message: "Please complete all fields !", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
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
