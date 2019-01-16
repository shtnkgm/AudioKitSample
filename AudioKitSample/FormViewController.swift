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

final class FormViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var former = Former(tableView: tableView)
    private let sectionFormers: [SectionFormer]
    private let name: String
    
    init(name: String, sectionFormers: [SectionFormer]) {
        self.name = name
        self.sectionFormers = sectionFormers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupFormer()
        title = name
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func setupFormer() {
        former.add(sectionFormers: sectionFormers)
    }
}
