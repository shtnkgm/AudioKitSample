//
//  VisualizationViewController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Then
import AudioKit
import AudioKitUI

final class VisualizationViewController: UIViewController {
    let audioPlot = EZAudioPlot()
    let microphone = AKMicrophone()
    
    private let name: String
    
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAudioKit()
        setupNodeOutputPlot()
        title = name
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        view.addSubview(audioPlot)
        audioPlot.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupAudioKit() {
        let frequencyTracker = AKFrequencyTracker(microphone)
        let booster = AKBooster(frequencyTracker, gain: 0)
        AudioKit.output = booster
        try? AudioKit.start()
    }
    
    func setupNodeOutputPlot() {
        let nodeOutputPlot = AKNodeOutputPlot(microphone, frame: .zero)
        nodeOutputPlot.plotType = .buffer
        nodeOutputPlot.shouldFill = true
        nodeOutputPlot.shouldMirror = true
        nodeOutputPlot.color = .red
        audioPlot.addSubview(nodeOutputPlot)
        nodeOutputPlot.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
