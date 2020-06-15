//
//  CloudFramework.swift
//  Pokedex
//
//  Created by Hector S. Villasano on 6/14/20.
//  Copyright © 2020 s. All rights reserved.
//

import Foundation
import CloudKit
class CloudFramework: NSObject {
    let database = CKContainer.default().publicCloudDatabase

    var leageCardRecords: [CKRecord] = []

    func createReacord(with cardID: String, completion: @escaping (Error?) -> ()) {
        let recordID = CKRecord.ID(recordName: UUID().uuidString)
        let record = CKRecord(recordType: "LeageCardID", recordID: recordID)

        record["cardID"] = cardID

        database.save(record) { record, error in
            if let error = error {
                completion(error)
            }

            guard let record = record else { return }
            self.leageCardRecords.append(record)
            completion(nil)
        }
    }

}
