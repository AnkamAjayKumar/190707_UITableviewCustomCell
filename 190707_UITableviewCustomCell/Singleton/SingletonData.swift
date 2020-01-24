//
//  SingletonData.swift
//  190707_UITableviewCustomCell
//
//  Created by Ankam Ajay Kumar on 28/12/19.
//  Copyright © 2019 Ankam Ajay Kumar. All rights reserved.
//

import UIKit
import CoreData

class SingletonData: NSObject {

    
    static var shared:SingletonData = SingletonData()
    
    var moc:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    
    private override init() {
        super.init()
    }
}
