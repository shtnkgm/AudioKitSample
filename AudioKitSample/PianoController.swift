//
//  PianoController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import AudioKit
import Former
import Then

class PianoController {
    let piano = AKRhodesPiano().then {
        $0.amplitude = 1.0
    }
    
    func makeViewController() -> UIViewController {
        let rows = Note.allCases.map { note in
            MyFormer.makeLabelRow(title: note.rawValue) { [weak self] in
                guard let self = self else { return }
                self.piano.start()
                self.piano.trigger(frequency: note.frequency)
            }
        }
        let section = SectionFormer(rowFormers: rows)
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(title: "Piano", sectionFormers: [section])
    }
}
