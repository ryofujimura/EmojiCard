//
//  PrevireProvider.swift
//  EmojiDictionary
//
//  Created by ryo fuj on 2/14/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instace
    }
}

class DeveloperPreview {
    static let instace = DeveloperPreview()
    private init() {}
    
    let emoji = EmojiModel(
        slug: "grinning-face",
        character: "😀",
        unicodeName: "grinning face",
        codePoint: "1F600",
        group: "smileys-emotion",
        subGroup: "face-smiling"
        )
}


