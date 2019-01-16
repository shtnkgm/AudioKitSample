//
//  Oscillator.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import AudioKit
import Former
import Then

class OscillatorController {
    let oscillator = AKOscillator().then {
        $0.frequency = 500
        $0.amplitude = 0.5
        $0.rampDuration = 0.5
        $0.detuningOffset = 0.5
        $0.detuningMultiplier = 0.5
    }
    
    func makeViewController() -> UIViewController {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeSwitchRow(title: "start") { [weak self] in
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
            },
            MyFormer.makeSliderRow(title: "detuningOffset") { [weak self] in
                guard let self = self else { return }
                self.oscillator.detuningOffset = Double($0)
            },
            MyFormer.makeSliderRow(title: "detuningMultiplier") { [weak self] in
                guard let self = self else { return }
                self.oscillator.detuningMultiplier = Double($0)
            }
            ])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(title: "Oscillator", sectionFormers: [section])
    }
}
