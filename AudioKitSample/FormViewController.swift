//
//  FormViewController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Former
import SnapKit
import AudioKit

class FormViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var former = Former(tableView: tableView)
    
    init(title: String, sectionFormers: [SectionFormer]) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        former.add(sectionFormers: sectionFormers)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try? AudioKit.stop()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
