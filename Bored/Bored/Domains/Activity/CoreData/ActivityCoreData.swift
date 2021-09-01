//
//  ActivityCoreData.swift
//  Bored
//
//  Created by Thiago Centurion on 01/09/21.
//

import UIKit
import CoreData

protocol ActivityCoreDataProtocol {
    func fetchActivities() throws -> [Activity]
    func save(activity: Activity) throws
    func update(activity: Activity) throws
}

final class ActivityCoreData: ActivityCoreDataProtocol {

    // MARK: Properties
    var managedContext: NSManagedObjectContext

    // MARK: - Initialization
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
}

// MARK: - Private methods
extension ActivityCoreData {

    private func activity(by activityEntity: ActivityEntity) -> Activity {
        .init(
            title: activityEntity.title ?? "",
            accessibility: activityEntity.accessibility,
            type: .init(rawValue: activityEntity.type ?? "") ?? .none,
            participants: Int(activityEntity.participants),
            price: activityEntity.price,
            link: URL(string: activityEntity.link ?? ""),
            key: activityEntity.key ?? "",
            initialDate: activityEntity.initialDate,
            status: .init(rawValue: activityEntity.status) ?? .none
        )
    }

    private func activityEntity(by activity: Activity) -> ActivityEntity {
        let entity = ActivityEntity(context: managedContext)
        entity.title = activity.title
        entity.accessibility = activity.accessibility
        entity.type = activity.type.rawValue
        entity.participants = Int16(activity.participants)
        entity.price = activity.price
        entity.link = activity.link?.absoluteString
        entity.key = activity.key
        entity.initialDate = activity.initialDate
        entity.status = activity.status.rawValue
        
        return entity
    }
}

// MARK: - ActivityCoreDataProtocol
extension ActivityCoreData {

    func fetchActivities() throws -> [Activity] {
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        return try managedContext.fetch(fetchRequest).map(activity(by:))
    }

    func save(activity: Activity) throws {
        let _ = activityEntity(by: activity)
        try managedContext.save()
    }

    func update(activity: Activity) throws {
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "key=$0", activity.key)

        let entity = try managedContext.fetch(fetchRequest).first
        entity?.title = activity.title
        entity?.accessibility = activity.accessibility
        entity?.type = activity.type.rawValue
        entity?.participants = Int16(activity.participants)
        entity?.price = activity.price
        entity?.link = activity.link?.absoluteString
        entity?.key = activity.key
        entity?.initialDate = activity.initialDate
        entity?.status = activity.status.rawValue

        try managedContext.save()
    }
}

// MARK: - NSManagedObjectContext
extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
