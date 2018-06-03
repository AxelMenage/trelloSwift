//
//  AddCardViewController.swift
//  trelloLike
//
//  Created by Marion  on 18/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ListPickerView: UIPickerView!
    
    let apiManager = APIManager()
    var lists = [List]()
    var selectedBoard: Board?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let key: String = UserDefaults.standard.object(forKey: "trelloKey") as! String
        let token: String = UserDefaults.standard.object(forKey: "trelloToken") as! String
        
        lists = apiManager.getListsBy(boardId: (selectedBoard?.id)!, withKey: key, andToken: token)
        
        self.ListPickerView.delegate = self
        self.ListPickerView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCardAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lists.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lists[row].name
    }

}
