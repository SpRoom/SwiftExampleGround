//
//  FlagToggleViewController.swift
//  ProperyWrapper
//
//  Created by xj on 2020/5/16.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import UIKit

class FlagToggleViewController: UIViewController {
    
    private let flag: Flag<Bool>
    private lazy var label = UILabel()
    private lazy var toggle = UISwitch()

    init(flag: Flag<Bool>) {
        self.flag = flag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = flag.name
        toggle.isOn = flag.wrappedValue

        toggle.addTarget(self,
            action: #selector(toggleFlag),
            for: .valueChanged
        )
    }
    
    @objc private func toggleFlag() {
        flag.wrappedValue = toggle.isOn
    }
}
