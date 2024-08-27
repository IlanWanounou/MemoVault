//
//  Item.swift
//  MemoVault
//
//  Created by Wanounou Ilan on 27/08/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var text: String
    var pin : Bool?
    
    init(text: String) {
        self.text = text
        self.pin = false
    }
}
