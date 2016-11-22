//
//  DataManager.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/20/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import Foundation

let kDatabaseName = "pokemon"
let kDatabaseExtension = "db"

class DataManager {
    static let defaultManager = DataManager()
    
    func getDatabaseFolderPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
    }
    
    // Copy database
    
    func copyDatabaseIfNeed() {
        
        // 1. Get bundle path 
        let bundlePath = Bundle.main.path(forResource: kDatabaseName, ofType: kDatabaseExtension)
        // 2.Get document path 
        let documentPath = self.getDatabaseFolderPath()
        
        print(documentPath)
        
        // 3. Check if file not exist
        if !FileManager.default.fileExists(atPath: documentPath) {
            // 4. Copy from bundlePath to documentPath 
            do {
                print(bundlePath)
                print(documentPath)
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: documentPath)
            } catch {
                print(error)
            }
        }
        
    }
    
    func selectPokemon(gen: Int)-> [Pokemon] {
        
        var pokemons = [Pokemon]()
        
        // 1. OpenDatabase 
        let databse = FMDatabase(path: self.getDatabaseFolderPath())
        databse?.open()
        
        // 2. Create query
        let selectQuery = "SELECT * FROM Pokemon WHERE gen = \(gen)"
        
        do {
            let result = try databse?.executeQuery(selectQuery, values: nil)
            while (result?.next())! {
                let id = result?.int(forColumn: "id")
                let name = result?.string(forColumn: "name")
                let tag = result?.string(forColumn: "tag")
                let gen = result?.int(forColumn: "gen")
                let img = result?.string(forColumn: "img")
                let color = result?.string(forColumn: "color")
                
                let pokemon = Pokemon(id: Int(id!), name: name!, tag: tag!, gen: Int(gen!), img: img!, color: color!)
                
                pokemons.append(pokemon)
            }
            print("Select Successfully")
        } catch {
             print("Select Failed: ",error)
        }
        
        // 4. Close databse
        databse?.close()
        
        return pokemons
    }
    
}

















