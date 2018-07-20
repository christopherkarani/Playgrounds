//
//  Downloader.swift
//  DownloadTask
//
//  Created by Chris Karani on 7/19/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation
import Cache
import Files

"path" = "file:///Users/apples/Library/Developer/CoreSimulator/Devices/9D18CB16-AC3B-4A1F-A0FE-25197F56F51B/data/Containers/Data/Application/Documents"

enum StringLiterals: String {
    case urlStore
}


protocol Resource {
    var url: URL { get }
    var cacheKey: String { get }
}

extension URL: Resource {
    var url: URL {
        return self
    }
    
    var cacheKey: String {
        return self.absoluteString
    }
}

struct DownloadedResource: Resource {
    var url: URL
    var cacheKey: String
}

class Downloader {
    let manager: StorageManager
    
    init(_ cacheManager: StorageManager = StorageManager.shared) {
        self.manager = cacheManager
    }
    func load(_ resource: Resource) {
        URLSession.shared.downloadTask(with: resource.url) { (temporaryUrl, response, error) in
            if let error = error {
                print(error); return
            }
            guard response != nil else  {print(error!); return}
            guard let temporaryUrl = temporaryUrl else { return }            
            let destinationUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let url = destinationUrl.appendingPathExtension(temporaryUrl.absoluteString)
            self.manager.setup(with: url)
            try! StorageManager.store?.setObject(url, forKey: url.absoluteString)
        }.resume()
    }
}
