//
//  CloudFramework.swift
//  Pokedex
//
//  Created by Hector S. Villasano on 6/14/20.
//  Copyright © 2020 s. All rights reserved.
//

import Foundation
import CloudKit


@objc (HSVCloudFramework)
class CloudFramework: NSObject {
    @objc let container = CKContainer.default()
    
    /// Save a CKRecord
    /// - Parameters:
    ///   - record: CKRecord
    ///   - completion: will return a error if save fails
    /// - Returns: nill if record saves
    @objc func save(record: CKRecord, completion: @escaping (Error?) -> ()) {
        let database = container.publicCloudDatabase
        database.save(record) { _, error in
            if let error = error {
                completion(error)
            }

            completion(nil)
        }
    }

    ///  perfroms fetch witih record Type Query, Fetch is sorted by modifacetion Date
    /// - Parameters:
    ///   - recordType: a string value of the record typr
    ///   - completion:  error / record data
    @objc func fetchRecords(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> ()) {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        let database = container.publicCloudDatabase
        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: false)]

        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(nil, error)
            }

            guard let records = records else { return }
            completion(records, nil)
        }
    }
}

extension CloudFramework {

    /// Create CKRecord wit a LeageCard Object
    /// - Parameter leageCard: LeageCard Object
    /// - Returns: Returns a CKRecord with LeageCard Attributes
    @objc func createLeageCardRecord(leageCard: HSVLeageCard) -> CKRecord{
        let recordID = CKRecord.ID()
        let record = CKRecord(recordType: "LeageCardID", recordID: recordID)
        record["cardID"] = leageCard.cardID
        record["badLeageCardValue"] = leageCard.badLeageCardValue;
        record["likeCount"] = 0;
        record["createdBy"] = "";
        return record
    }
}
