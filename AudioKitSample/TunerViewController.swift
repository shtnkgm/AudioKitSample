//
//  TunerViewController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Then
import AudioKit

class TunerViewController: UIViewController {
    private let label = UILabel().then {
        $0.text = "-"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 200)
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
        title = name
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try? AudioKit.stop()
    }
    
    private func setupLayout() {
        view.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

