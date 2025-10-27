//
//  TransactionItem+CoreDataProperties.swift
//  Income-App
//
//  Created by Zoltan Vegh on 27/10/2025.
//
//

public import Foundation
public import CoreData


public typealias TransactionItemCoreDataPropertiesSet = NSSet

extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?

}

extension TransactionItem : Identifiable {

}

extension TransactionItem {
    
    var wrappedId: UUID {
        return id!
    }
    
    var wrappedTitle: String {
        return title ?? ""
    }
    
    var wrappedDate: Date {
        return date ?? Date()
    }
    
    var wrappedTransactionType: TransactionType {
        return TransactionType(rawValue: Int(type)) ?? .expense
    }
    
    var wrappedAmount: Double {
        return amount
    }
    
}
