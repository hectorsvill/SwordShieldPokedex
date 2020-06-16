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
    let container = CKContainer.default()

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

    ///  perfroms fetch witih record Type Query
    /// - Parameters:
    ///   - recordType: a string value of the record typr
    ///   - completion:  error / record data
    @objc func fetchRecords(recordType: String, completion: @escaping ([CKRecord]?, Error?) -> ()) {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        let database = container.publicCloudDatabase

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

    /// Create a Leage Card ID CKRecord
    /// - Parameter cardID: string value of ID
    /// - Returns: a CKRecord  with cardID key/value
    @objc func createLeageCardRecord(cardID: String) -> CKRecord{
        let recordID = CKRecord.ID()
        let record = CKRecord(recordType: "LeageCardID", recordID: recordID)
        record["cardID"] = cardID
        return record
    }
}
