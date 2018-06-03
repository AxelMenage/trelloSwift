//
//  BoardsTableViewController.swift
//  trelloLike
//
//  Created by Marion  on 17/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BoardsTableViewController: UITableViewController {
    
    var boards = [Board]()
    let apiManager = APIManager()
    var selectedBoard: Board?
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(vc!, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if(UserDefaults.standard.object(forKey: "trelloUsername") != nil){
            let username: String = UserDefaults.standard.object(forKey: "trelloUsername") as! String
            let key: String = UserDefaults.standard.object(forKey: "trelloKey") as! String
            let token: String = UserDefaults.standard.object(forKey: "trelloToken") as! String
            
            boards = apiManager.getBoardsBy(username: username, withKey: key, andToken: token)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(vc!, animated: true, completion: nil)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.boards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.boards[indexPath.row].name
        
        selectedBoard = self.boards[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBoardDetails" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let board = boards[indexPath.row]
                let tabBarC : UITabBarController = segue.destination as! UITabBarController
                let desView: CardsTableViewController = tabBarC.viewControllers?.first as! CardsTableViewController
                desView.selectedBoard = board
                let memberView: MembersTableViewController = tabBarC.viewControllers?[1] as! MembersTableViewController
                memberView.selectedBoard = board
            }
        }
     }

}
