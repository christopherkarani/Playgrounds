//
//  File.swift
//  DownloadTask
//
//  Created by Chris Karani on 7/19/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation
import Cache

class StorageManager {
    static let shared = StorageManager()
    var destinationUrl: URL?
    static var store: Storage<URL>?
    
    public  static func store(atDestination url: URL) -> Storage<URL> {
        let diskConfig = DiskConfig(name: StringLiterals.urlStore.rawValue, expiry: .never, maxSize: 1000, directory: url, protectionType: .complete)
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 50, totalCostLimit: 50)
        
        let storage = try! Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: URL.self))
        return storage
    }
    
    func setup(with url: URL) {
        StorageManager.store = StorageManager.store(atDestination: url)
    }
}
