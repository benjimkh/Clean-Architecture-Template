//
//  Transaction.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation


extension Entities.Responses {
    struct Transaction: Codable {
        let id: String           // Unique identifier for the transaction
        let date: String           // Date and time of the transaction
        let amount: String      // Transaction amount
        let userDescription: String // User-provided description for the transaction
        let status: String       // Transaction status (e.g., "SUCCESS" or "FAILURE")
        let isWithdraw: Bool     // Indicates whether it's a withdrawal transaction
        
        /// Details API Response Specific
        /// These two keys has been defined nullable due to the fact that these two are only presented in details api
        
        let bank: Bank?           // Bank details related to the transaction
        let person: Person?       // Information about the person involved in the transaction
        
    }
}
