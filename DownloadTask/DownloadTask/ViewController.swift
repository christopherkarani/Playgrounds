//
//  ViewController.swift
//  DownloadTask
//
//  Created by Chris Karani on 7/19/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit
import QuickLook


class QuickLookController: QLPreviewController {
    static var fileUrls = [NSURL]()
    var urls : [NSURL] {
        get {
            return QuickLookController.fileUrls
        }
        set {
            QuickLookController.fileUrls.append(contentsOf: newValue)
        }
    }
}

extension QuickLookController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return urls.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return urls[index]
    }
}



class ViewController: UIViewController {
    let progressView : CKProgressView = {
        let progressView = CKProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    fileprivate func setupProgressView() {
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -14),
            progressView.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    private func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        view.addGestureRecognizer(gesture)
    }
    
    private func setupLongPressGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func tapGestureAction() {
        //progressView.setProgress(50, animated: true)

    }
    
    @objc fileprivate func longPressGestureAction() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressView()
        setupTapGesture()
        setupLongPressGesture()
        
        let url = URL(string: "http://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf")!
        Downloader().load(url)
        // Do any additional setup after loading the view, typically from a nib.
    }
}

