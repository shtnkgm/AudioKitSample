//
//  Oscillator.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import AudioKit
import Former

class OscillatorController {
    let oscillator = AKOscillator()
    
    func makeViewController() -> UIViewController {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeSwitchRow(title: "enable") { [weak self] in
                guard let self = self else { return }
                $0 ? self.oscillator.start() : self.oscillator.stop()
            },
            MyFormer.makeSliderRow(title: "frequency", min: 0, max: 1000) { [weak self] in
                guard let self = self else { return }
                self.oscillator.frequency = Double($0)
            },
            MyFormer.makeSliderRow(title: "amplitude") { [weak self] in
                guard let self = self else { return }
                self.oscillator.amplitude = Double($0)
            },
            MyFormer.makeSliderRow(title: "rampDuration") { [weak self] in
                guard let self = self else { return }
                self.oscillator.rampDuration = Double($0)
            }
            ])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(title: "Oscillator", sectionFormers: [section])
    }
}
