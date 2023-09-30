//
//  Globals.swift
//  Sanskrit-052
//
//  Created by Maleesha Wijeratne on 23/09/2023.
//

import Foundation

var userUID: String = ""
var selectedImageName = "image0"

struct Expense: Identifiable {
    let id = UUID()
    let amount: Double
    let description: String
    let location: String
    let category: String
}
