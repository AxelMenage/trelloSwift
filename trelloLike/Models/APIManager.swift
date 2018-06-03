//
//  APIManager.swift
//  trelloLike
//
//  Created by Marion  on 18/05/2018.
//  Copyright © 2018 AxelM. All rights reserved.
//

import Foundation

class APIManager{
    
    let baseUrl: String
    let jsonDecoder: JSONDecoder
    
    init(){
        baseUrl = "https://api.trello.com/1/"
        jsonDecoder = JSONDecoder()
    }
    
    func getBoardsBy(username: String, withKey: String, andToken: String) -> [Board]{
        var boards = [Board]()
        let url = URL(string: baseUrl + "members/"+username+"/boards?key="+withKey+"&token="+andToken)!
        
        do {
            let jsonData = try Data(contentsOf: url);
            boards = try jsonDecoder.decode(Array<Board>.self, from: jsonData)
        }
        catch {
            print(error)
        }
        return boards
    }
    
    func getCardsBy(boardId: String, withKey: String, andToken: String) -> [Card]{
        var cards = [Card]()
        let url = URL(string: baseUrl + "boards/"+boardId+"/cards?key="+withKey+"&token="+andToken)!
        let jsonData = try! Data(contentsOf: url)
        do {
            cards = try jsonDecoder.decode(Array<Card>.self, from: jsonData)
        }
        catch {
            print(error)
        }
        return cards
    }
    
    func getListsBy(boardId: String, withKey: String, andToken: String) -> [List]{
        var lists = [List]()
        let url = URL(string: baseUrl + "boards/"+boardId+"/lists?key="+withKey+"&token="+andToken)!
        let jsonData = try! Data(contentsOf: url)
        do {
            lists = try jsonDecoder.decode(Array<List>.self, from: jsonData)
        }
        catch {
            print(error)
        }
        return lists
    }
    
    func getMembersBy(boardId: String, withKey: String, andToken: String) -> [Member]{
        var members = [Member]()
        let url = URL(string: baseUrl + "boards/"+boardId+"/members?key="+withKey+"&token="+andToken)!
        let jsonData = try! Data(contentsOf: url)
        do {
            members = try jsonDecoder.decode(Array<Member>.self, from: jsonData)
        }
        catch {
            print(error)
        }
        return members
    }
}
