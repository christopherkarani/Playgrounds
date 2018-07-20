//
//  CKProgressView.swift
//  DownloadTask
//
//  Created by Chris Karani on 7/19/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

class CKProgressView: UIProgressView {
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setupStyle()
        setupColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CKProgressView {
    private func setupColor() {
        progressTintColor = .yellow
        backgroundColor = .white
    }
    
    private func setupStyle() {
        progressViewStyle = .default
    }
}
