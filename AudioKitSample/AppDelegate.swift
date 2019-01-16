//
//  AppDelegate.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/14.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import UIKit
import Former
import AudioKit

/*
 AudioKitSample[21524:4207235] [access] This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSMicrophoneUsageDescription key with a string value explaining to the user how the app uses this data.
 */

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
    
    private let oscillatorController = OscillatorController()
    private let pianoController = PianoController()
    private func makeListViewController() -> FormViewController {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeLabelRow(title: "Oscillator") { [weak self] in
                guard let self = self else { return }
                AudioKit.output = self.oscillatorController.oscillator
                self.startAudioKit()
                self.push(self.oscillatorController.makeViewController())
            },
            MyFormer.makeLabelRow(title: "Piano") { [weak self] in
                guard let self = self else { return }
                AudioKit.output = self.pianoController.piano
                self.startAudioKit()
                self.push(self.pianoController.makeViewController())
            },
            MyFormer.makeLabelRow(title: "Vocal") { [weak self] in self?.push(self?.makeVocalViewController()) },
            MyFormer.makeLabelRow(title: "Tuner") { [weak self] in self?.push(self?.makeTunerViewController()) },
            MyFormer.makeLabelRow(title: "Visualization")  { [weak self] in self?.push(self?.makeVisualizationViewController()) }
            ])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(title: "List", sectionFormers: [section])
    }
    
    private func makeVocalViewController() -> FormViewController {
        let section = SectionFormer(rowFormers: [
            MyFormer.makeSwitchRow(title: "start") { _ in },
            MyFormer.makeSliderRow(title: "frequency", min: 0, max: 1000) { _ in },
            MyFormer.makeSliderRow(title: "amplitude") { _ in },
            MyFormer.makeSliderRow(title: "rampDuration") { _ in },
            MyFormer.makeSliderRow(title: "tonguePosition") { _ in },
            MyFormer.makeSliderRow(title: "tongueDiameter") { _ in },
            MyFormer.makeSliderRow(title: "tenseness") { _ in },
            MyFormer.makeSliderRow(title: "nasality") { _ in }
            ])
            .set(headerViewFormer: MyFormer.makeHeader(title: ""))
        return FormViewController(title: "Vocal", sectionFormers: [section])
    }
    
    private func makeTunerViewController() -> UIViewController {
        return TunerViewController(name: "Tuner")
    }
    
    private func makeVisualizationViewController() -> UIViewController {
        return VisualizationViewController(title: "Visualization")
    }
    
    private func startAudioKit() {
        do {
            try AudioKit.start()
        } catch {
            print(error)
        }
    }
}

