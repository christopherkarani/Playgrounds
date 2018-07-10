//
//  ViewController.swift
//  Demoo
//
//  Created by Chris Karani on 7/9/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit
import Rooster

struct Post: Codable {
    let userID: Int
    let id: Int
    let title: String
    let body: String
}





class ViewController: UIViewController {
    
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let res : CodableResource<Post>
        let rooster = Rooster<res>
        
    
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

