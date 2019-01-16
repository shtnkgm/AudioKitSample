//
//  VisualizationViewController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Then
import Former
import SnapKit
import AudioKit
import AudioKitUI

final class VisualizationViewController: UIViewController {
    private let microphone = AKMicrophone()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 0
    }
    
    private lazy var former = Former(tableView: tableView)
    
    private lazy var nodeOutputPlot = AKNodeOutputPlot(microphone, frame: .zero).then {
        $0.plotType = .buffer
        $0.shouldFill = false
        $0.shouldMirror = false
        $0.shouldCenterYAxis = true
        $0.color = .red
    }
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupFormer()
        setupAudioKit()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try? AudioKit.stop()
    }
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        stackView.addArrangedSubview(nodeOutputPlot)
        stackView.addArrangedSubview(tableView)
    }
    
    private func setupFormer() {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeSwitchRow(title: "plotType(rolling)") { [weak self] in self?.nodeOutputPlot.plotType = $0 ? .rolling : .buffer },
            MyFormer.makeSwitchRow(title: "shouldFill") { [weak self] in self?.nodeOutputPlot.shouldFill = $0 },
            MyFormer.makeSwitchRow(title: "shouldMirror") { [weak self] in self?.nodeOutputPlot.shouldMirror = $0 },
            MyFormer.makeSwitchRow(title: "shouldCenterYAxis") { [weak self] in self?.nodeOutputPlot.shouldCenterYAxis = !$0 }
            ])
        former.add(sectionFormers: [section])
    }
    
    private func setupAudioKit() {
        let frequencyTracker = AKFrequencyTracker(microphone)
        let booster = AKBooster(frequencyTracker)
        AudioKit.output = booster
        try? AudioKit.start()
    }
}
