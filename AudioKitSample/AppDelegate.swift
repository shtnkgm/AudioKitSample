//
//  AppDelegate.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/14.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Former

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    private func setupWindow() {
        let listViewController = makeListViewController()
        navigationController = UINavigationController(rootViewController: listViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func push(_ viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeListViewController() -> FormViewController {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeLabelRow(title: "Oscillator") { [weak self] in self?.push(self?.makeOscillatorViewController()) }
            ])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(name: "List", sectionFormers: [section])
    }
    
    private func makeOscillatorViewController() -> FormViewController {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeSwitchRow(title: "enable") { _ in },
            MyFormer.makeSliderRow(title: "frequency", min: 0, max: 1000) { _ in },
            MyFormer.makeSliderRow(title: "amplitude") { _ in },
            MyFormer.makeSliderRow(title: "rampDuration") { _ in }
            ])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(name: "Oscillator", sectionFormers: [section])
    }
}

