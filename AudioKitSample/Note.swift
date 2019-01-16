//
//  Note.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import Foundation

enum Note: String {
    case ド
    case レ
    case ミ
    case ファ
    case ソ
    case ラ
    case シ
    
    var frequency: Float {
        switch self {
        case .ド: return 261.626
        case .レ: return 293.665
        case .ミ: return 329.628
        case .ファ: return 349.228
        case .ソ: return 391.995
        case .ラ: return 440.000
        case .シ: return 493.883
        }
    }
    
    var lowFrequency: Float {
        return frequency / 2.0
    }
    
    var highFrequency: Float {
        return frequency * 2.0
    }
}

extension Note: CaseIterable { }
