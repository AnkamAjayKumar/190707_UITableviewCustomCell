//
//  HomePageTableView.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 30/12/19.
//  Copyright © 2019 Ankam Ajay Kumar. All rights reserved.
//

import UIKit
import CoreData

class HomePageTableView: UITableViewController, UISearchResultsUpdating {
    
    //MARK:- Instance Creation
    var fetchedData:[NSManagedObject]!
    var actorsFetchedImage = [NSData]()
    var actorsFetchedName = [String]()
    var actorsFetchedAge = [Int16]()
    var deleteActorData = [NSManagedObject]()
    var actorsFetchedMobile = [String]()
    var cricketorsFetchedImage = [NSData]()
    var cricketorsFetchedName = [String]()
    var cricketorsFetchedAge = [Int16]()
    var cricketorsFetchedMobile = [String]()
    var deleteCricketorData = [NSManagedObject]()
    var politiciansFetchedImage = [NSData]()
    var politiciansFetchedName = [String]()
    var politiciansFetchedAge = [Int16]()
    var politiciansFetchedMobile = [String]()
    var deletePoliticianData = [NSManagedObject]()
    var searchBarObj:UISearchController!
    var filteredActors = [String]()
    var filteredCricketors = [String]()
    var filteredPoliticians = [String]()
    
    //MARK:- IBAction
    @IBAction func addDetailsActionBtn(_ sender: Any) {
        
        let addDetails = storyboard?.instantiateViewController(identifier: "AddDetails") as! AddDetails
        self.navigationController?.pushViewController(addDetails, animated: true)
    }
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        var actorCellXib = UINib(nibName: "ActorsCell", bundle: nil)
        var criketorCellXib = UINib(nibName: "CricketorsCell", bundle: nil)
        var politicianCellXib = UINib(nibName: "PoliticiansCell", bundle: nil)
        
        tableView.register(actorCellXib, forCellReuseIdentifier: "ActorCell")
        tableView.register(criketorCellXib, forCellReuseIdentifier: "CricketorCell")
        tableView.register(politicianCellXib, forCellReuseIdentifier: "PoliticianCell")
        
        searchBarObj = UISearchController(searchResultsController: nil)
        searchBarObj.searchResultsUpdater = self
        searchBarObj.searchBar.placeholder = "Use me to search"
        tableView.tableHeaderView = searchBarObj.searchBar
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshControlTarget), for: UIControl.Event.touchUpInside)
        
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        tableView.reloadData()
    }
    
    //method to endrefresh
    @objc func refreshControlTarget()
    {
        print("Refresh Done")
        refreshControl?.endRefreshing()
    }
    
    //method to fetch data
    func fetchData()
    {
        actorsFetchedImage = [NSData]()
        actorsFetchedName = [String]()
        actorsFetchedAge = [Int16]()
        actorsFetchedMobile = [String]()
        cricketorsFetchedImage = [NSData]()
        cricketorsFetchedName = [String]()
        cricketorsFetchedAge = [Int16]()
        cricketorsFetchedMobile = [String]()
        politiciansFetchedImage = [NSData]()
        politiciansFetchedName = [String]()
        politiciansFetchedAge = [Int16]()
        politiciansFetchedMobile = [String]()
        
        let fetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Adddetails")
        
        do
        {
            fetchedData = try SingletonData.shared.moc.fetch(fetch) as! [NSManagedObject]
            print("Data fetched successfully")
        }
        catch
        {
            print("Unable to fetch", error.localizedDescription)
        }
        
        for i in fetchedData
        {
            let noImage = UIImage(named: "noImage")
            let noImageData = noImage?.pngData() as! NSData
            
            
            if(i.value(forKey: "selectedSC") as! String == "Actor" )
            {
                actorsFetchedName.append(i.value(forKey: "name") as! String)
                actorsFetchedAge.append(i.value(forKey: "age") as! Int16)
                actorsFetchedMobile.append(i.value(forKey: "mobile") as! String)
                actorsFetchedImage.append(i.value(forKey: "profilepic") as? NSData ?? noImageData)
                deleteActorData.append(i)
            }
            else if(i.value(forKey: "selectedSC") as! String == "Cricketer" )
            {
                cricketorsFetchedName.append(i.value(forKey: "name") as! String)
                cricketorsFetchedAge.append(i.value(forKey: "age") as! Int16)
                cricketorsFetchedMobile.append(i.value(forKey: "mobile") as! String)
                cricketorsFetchedImage.append(i.value(forKey: "profilepic") as? NSData ?? noImageData)
                deleteCricketorData.append(i)
            }
            else
            {
                politiciansFetchedName.append(i.value(forKey: "name") as! String)
                politiciansFetchedAge.append(i.value(forKey: "age") as! Int16)
                politiciansFetchedMobile.append(i.value(forKey: "mobile") as! String)
                politiciansFetchedImage.append(i.value(forKey: "profilepic") as? NSData ?? noImageData)
                deletePoliticianData.append(i)
            }
            
        }
        
    }
     
    //MARK:- UISearchResultsUpdating delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        var predicateObj = NSPredicate(format: "self contains[c] %@", searchController.searchBar.text!)
        
        filteredActors = ((actorsFetchedName as! NSArray).filtered(using: predicateObj)) as! [String]
        filteredCricketors = ((cricketorsFetchedName as! NSArray).filtered(using: predicateObj)) as! [String]
        filteredPoliticians = ((politiciansFetchedName as! NSArray).filtered(using: predicateObj)) as! [String]
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0)
        {
            if(searchBarObj.isActive == true)
            {
                return filteredActors.count
            }
            else
            {
                return actorsFetchedName.count
            }
            
        }
        else if(section == 1)
        {
            if(searchBarObj.isActive == true)
            {
                return filteredCricketors.count
            }
            else
            {
                return cricketorsFetchedName.count
            }
        }
        else
        {
            if(searchBarObj.isActive == true)
            {
                return filteredPoliticians.count
            }
            else
            {
                return politiciansFetchedName.count
            }
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell", for: indexPath) as! ActorsCell
            
            cell.actorImage.image = UIImage(data: actorsFetchedImage[indexPath.row] as Data)
            cell.actorImage.translatesAutoresizingMaskIntoConstraints = false
            cell.actorImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
            cell.actorImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
            cell.actorNameLbl.text = actorsFetchedName[indexPath.row]
            cell.actorAgeLbl.text = "Age: \(String(actorsFetchedAge[indexPath.row]))"
            cell.actorMobileLbl.text = "Mobile: \(actorsFetchedMobile[indexPath.row])"
            cell.accessoryType = .disclosureIndicator
            
            return cell
            
        }
        else if(indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CricketorCell", for: indexPath) as! CricketorsCell
            
            cell.cricketorImage.image = UIImage(data: cricketorsFetchedImage[indexPath.row] as Data)
            cell.cricketorNameLbl.text = cricketorsFetchedName[indexPath.row]
            cell.cricketorAge.text = "Age: \(String(cricketorsFetchedAge[indexPath.row]))"
            cell.cricketorMobileLbl.text = "Mobile: \(cricketorsFetchedMobile[indexPath.row])"
            cell.accessoryType = .disclosureIndicator
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PoliticianCell", for: indexPath) as! PoliticiansCell
            
            cell.politicianImage.image = UIImage(data: politiciansFetchedImage[indexPath.row] as Data)
            cell.politicianNameLbl.text = politiciansFetchedName[indexPath.row]
            cell.politicianAgeLbl.text = "Age: \(String(politiciansFetchedAge[indexPath.row]))"
            cell.politicianMobileLbl.text = "Mobile: \(politiciansFetchedMobile[indexPath.row])"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        // Configure the cell...

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0)
        {
            return "Actors"
        }
        else if(section == 1)
        {
            return "Cricketors"
        }
        else
        {
            return "Politicians"
        }
        
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
        
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Delete the row from the data source
        if editingStyle == .delete {
            if(indexPath.section == 0)
            {
                SingletonData.shared.moc.delete(self.deleteActorData[indexPath.row])
                do
                {
                    try SingletonData.shared.moc.save()
                    deleteActorData.removeAll()
                    self.fetchData()
                    self.tableView.reloadData()
                    print("deleted row from Actors")
                }
                catch
                {
                    print("Unable to delete from Actors", error.localizedDescription)
                }
            }
            else if(indexPath.section == 1)
            {
                SingletonData.shared.moc.delete(self.deleteCricketorData[indexPath.row
                    ])
                do
                {
                    try SingletonData.shared.moc.save()
                    deleteCricketorData.removeAll()
                    self.fetchData()
                    self.tableView.reloadData()
                    print("deleted row from Cricketors")
                }
                catch
                {
                    print("Unable to delete from Cricketors", error.localizedDescription)
                }
            }
            else
            {
                SingletonData.shared.moc.delete(self.deletePoliticianData[indexPath.row])
                do
                {
                    try SingletonData.shared.moc.save()
                    deletePoliticianData.removeAll()
                    self.fetchData()
                    self.tableView.reloadData()
                    print("deleted row from Politicians")
                }
                catch
                {
                    print("Unable to delete from Politicians", error.localizedDescription)
                }
            }
            
        }
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
