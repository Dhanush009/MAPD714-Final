//
//  Bmi+CoreDataProperties.swift
//  BMIApp
//
//  Created by Dhanush Sriram on 2022-12-15.
//
//

import Foundation
import CoreData


extension Bmi {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bmi> {
        return NSFetchRequest<Bmi>(entityName: "Bmi")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var weight: Double
    @NSManaged public var height: Double
    @NSManaged public var bmi: Double
    @NSManaged public var date: Date?

}

extension Bmi : Identifiable {

}
