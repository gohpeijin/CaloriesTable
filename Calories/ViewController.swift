//
//  ViewController.swift
//  Calories
//
//  Created by gohpeijin on 06/08/2021.
//  Copyright © 2021 pj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelNoItem: UILabel! // this will show when no searchable item
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var caloriesTableView: UITableView!
    var searchCaloriesKeys = [String]() // new list to store the search result's key, so table view will updated to the new list
    var caloriesList:[String:String] = [:] // dict to store all the caloreis of this app
    var caloriesKeys = [String]() // to store all the key
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        caloriesKeys = Array(caloriesList.keys).sorted()
        searchCaloriesKeys = caloriesKeys // assign to the searchlist as initial no searching is form so display original items
        caloriesTableView.register(CaloriesTableViewCell.nib(), forCellReuseIdentifier: CaloriesTableViewCell.identifier)
        
        searchBar.delegate = self
        caloriesTableView.dataSource = self
    }

    func retrieveData(){
        if let filePath = Bundle.main.path(forResource: "calories", ofType: "plist") {
            
            // get Data from the file
            if let plistData = FileManager.default.contents(atPath: filePath) {
                
                do {
                    // deserialize Data and return a property list
                    //  of type Any
                    let plistObject = try PropertyListSerialization.propertyList(
                        from: plistData,
                        options: PropertyListSerialization.ReadOptions(),
                        format: nil)
                    
                    // downcast the property list
                    let calories = plistObject as? [String:String]
                    
                    // assign values to a list
                    if let calories = calories {
                        caloriesList = calories

                    }
                } catch {
                    print("Error serializing data from property list")
                }
            } else {
                print("Error reading data from property list file")
            }
        } else {
            print("Property list file does not exist")
        }
    }
}


extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCaloriesKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CaloriesTableViewCell.identifier, for: indexPath) as! CaloriesTableViewCell
        
        // change the selected background color
        let backgroundview = UIView()
        backgroundview.backgroundColor = UIColor.init(red: 124/255, green: 152/255, blue: 180/255, alpha: 0.2)
        cell.selectedBackgroundView = backgroundview

        let selectedKey = searchCaloriesKeys[indexPath.row]
        cell.imageFood.image = UIImage(named: selectedKey.lowercased())
        cell.labelFoodName.text = selectedKey
        cell.labelFoodCalories.text = "\(caloriesList[selectedKey] ?? "N.A.") per 100g"

        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText:String){
        if (searchText.trimmingCharacters(in: .whitespaces) == ""){
           searchCaloriesKeys = caloriesKeys
        }
        else{
            // match the search string with the food's calories array
            searchCaloriesKeys = caloriesKeys.filter({$0.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))})
        }
        
        // to show this label when there is no item found
        if(searchCaloriesKeys.count == 0){
            caloriesTableView.separatorStyle = .none
            labelNoItem.isHidden = false
        }
        else{
            caloriesTableView.separatorStyle = .singleLine
            labelNoItem.isHidden = true
        }
        caloriesTableView.reloadData()
    }
}

