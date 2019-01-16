//
//  Former.swift
//  AudioKitSample
//
//  Created by Shota Nakagami on 2019/01/16.
//  Copyright © 2019 Shota Nakagami. All rights reserved.
//

import Former
import UIKit

enum MyFormer {
    static func makeHeader(title: String, height: CGFloat = 60) -> LabelViewFormer<FormLabelHeaderView> {
        return LabelViewFormer<FormLabelHeaderView>()
            .configure {
                $0.text = title
                $0.viewHeight = height
        }
    }
    
    static func makeRow(title: String, height: CGFloat = 60, onSelected: @escaping () -> Void) -> LabelRowFormer<FormLabelCell> {
        return LabelRowFormer<FormLabelCell>()
            .configure {
                $0.text = title
                $0.rowHeight = height
            }.onSelected { _ in
                onSelected()
        }
    }
    
    static func makeRow(title: String, height: CGFloat = 60, isOn: Bool = false, onSwitchChanged: @escaping (_ isOn: Bool) -> Void) -> SwitchRowFormer<FormSwitchCell> {
        return SwitchRowFormer<FormSwitchCell> {
                $0.titleLabel.text = title
                $0.switchButton.isOn = isOn
            }
            .configure {
                $0.rowHeight = height
            }.onSwitchChanged {
                onSwitchChanged($0)
        }
    }
    
    static func makeRow(title: String, height: CGFloat = 60, min: Float, max: Float, value: Float, onValueChanged: @escaping (_ value: Float) -> Void) -> SliderRowFormer<FormSliderCell> {
        return SliderRowFormer<FormSliderCell> {
            $0.titleLabel.text = title
            $0.slider.value = value
            $0.slider.minimumValue = min
            $0.slider.maximumValue = max
            }
            .configure {
                $0.rowHeight = height
            }.onValueChanged {
                onValueChanged($0)
        }
    }
}
