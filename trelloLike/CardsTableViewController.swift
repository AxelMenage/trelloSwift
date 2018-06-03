//
//  CardsTableViewController.swift
//  trelloLike
//
//  Created by Marion  on 18/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CardsTableViewController: UITableViewController {
    
    var selectedBoard: Board?
    
    var cards = [Card]()
    var lists = [List]()
    var cardsBysection = [[Card]]()
    let apiManager = APIManager()
    var selectedCard: Card?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let key: String = UserDefaults.standard.object(forKey: "trelloKey") as! String
        let token: String = UserDefaults.standard.object(forKey: "trelloToken") as! String
        
        lists = apiManager.getListsBy(boardId: (selectedBoard?.id)!, withKey: key, andToken: token)
        cards = apiManager.getCardsBy(boardId: (selectedBoard?.id)!, withKey: key, andToken: token)

        for (_, list) in lists.enumerated() {
            var cardsOfSection = [Card]()
            for (_, card) in cards.enumerated() {
                if(card.idList == list.id){
                    cardsOfSection.append(card)
                }
            }
            cardsBysection.append(cardsOfSection)
        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return lists.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cardsBysection[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.lists[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.cardsBysection[indexPath.section][indexPath.row].name
        
        selectedCard = self.cardsBysection[indexPath.section][indexPath.row]
        
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
            
            let addCard : AddCardViewController = segue.destination as! AddCardViewController
            addCard.selectedBoard = selectedBoard
            
        }
    }
    

}
