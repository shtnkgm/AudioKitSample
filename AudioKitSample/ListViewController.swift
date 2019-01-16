//
//  ListViewController.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/14.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Former
import SnapKit

class ListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var former = Former(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupFormer() {
        let section = SectionFormer(rowFormers: [])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
    }
    
    
}

