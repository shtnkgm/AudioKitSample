//
//  VisualizationViewController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Then
import SnapKit
import AudioKit
import AudioKitUI

final class VisualizationViewController: UIViewController {
    private let audioPlot = EZAudioPlot()
    private let microphone = AKMicrophone()
    
    private lazy var nodeOutputPlot = AKNodeOutputPlot(microphone, frame: .zero).then {
        $0.plotType = .buffer
        $0.shouldFill = true
        $0.shouldMirror = true
        $0.color = .red
    }
    
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
        title = name
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try? AudioKit.stop()
    }
    
    private func setupLayout() {
        view.addSubview(audioPlot)
        audioPlot.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        audioPlot.addSubview(nodeOutputPlot)
        nodeOutputPlot.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupAudioKit() {
        let frequencyTracker = AKFrequencyTracker(microphone)
        let booster = AKBooster(frequencyTracker)
        AudioKit.output = booster
        try? AudioKit.start()
    }
}
