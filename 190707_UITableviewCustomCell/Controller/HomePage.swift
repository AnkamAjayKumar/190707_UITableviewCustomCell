//
//  HomePage.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 27/12/19.
//  Copyright © 2019 Ankam Ajay Kumar. All rights reserved.
//

import UIKit
import CoreData

class HomePage: UIViewController {

    
    //MARK:- Instance Creation
    var fetchedData:[NSManagedObject]!
    var actorsFetchedImage = [NSData]()
    var actorsFetchedName = [String]()
    var actorsFetchedAge = [Int16]()
    var actorsFetchedMobile = [String]()
    var cricketorsFetchedImage = [NSData]()
    var cricketorsFetchedName = [String]()
    var cricketorsFetchedAge = [Int16]()
    var cricketorsFetchedMobile = [String]()
    var politiciansFetchedImage = [NSData]()
    var politiciansFetchedName = [String]()
    var politiciansFetchedAge = [Int16]()
    var politiciansFetchedMobile = [String]()
    
    @IBAction func addDetailsActionBtn(_ sender: Any) {
        
        let addDetails = storyboard?.instantiateViewController(identifier: "AddDetails") as! AddDetails
        navigationController?.pushViewController(addDetails, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData()
    {
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
                actorsFetchedImage.append(i.value(forKey: "profilepic") as! NSData ?? noImageData)
            }
            else if(i.value(forKey: "selectedSC") as! String == "Cricketer" )
            {
                cricketorsFetchedName.append(i.value(forKey: "name") as! String)
                cricketorsFetchedAge.append(i.value(forKey: "age") as! Int16)
                cricketorsFetchedMobile.append(i.value(forKey: "mobile") as! String)
                cricketorsFetchedImage.append(i.value(forKey: "profilepic") as! NSData ?? noImageData)
            }
            else
            {
                politiciansFetchedName.append(i.value(forKey: "name") as! String)
                politiciansFetchedAge.append(i.value(forKey: "age") as! Int16)
                politiciansFetchedMobile.append(i.value(forKey: "mobile") as! String)
                politiciansFetchedImage.append(i.value(forKey: "profilepic") as! NSData ?? noImageData)
            }
            
        }
        
    }
    
    //MARK:- UITableView Delegates Methods
    

    

}
