//
//  KanaCharacter.swift
//  KanaQuest
//
//  Created by Hanna on 01/08/24.
//

import Foundation

struct KanaCharacter: Decodable, Hashable, Identifiable {
    var id: String { kana }
    var script: String
    var type: String
    var kana: String
    var romaji: String
}
