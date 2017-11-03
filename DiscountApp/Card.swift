//
//  Card+CoreDataClass.swift
//  DiscountApp
//
//  Created by andriibilan on 11/1/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Card)
public class Card: NSManagedObject {
    
    @NSManaged public var cardDate: NSDate?
    @NSManaged public var cardDescription: String?
    @NSManaged public var cardName: String?
    @NSManaged public var cardFrontImage: String?
}
