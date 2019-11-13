//
//  NSCustomPersistentContainer.swift
//  receitas-jacquenan
//
//  Created by Jacqueline Alves on 12/11/19.
//  Copyright © 2019 jacquenan. All rights reserved.
//

import CoreData

class NSCustomPersistentContainer: NSPersistentCloudKitContainer {
    override class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.receitas-jacquenan")
        storeURL = storeURL?.appendingPathComponent("receitas-jacquenan.sqlite")
        
        return storeURL ?? URL(fileURLWithPath: "")
    }
}
