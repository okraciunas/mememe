//
//  DetailMemeViewController.swift
//  MemeMe
//
//  Created by terced-leonardoo on 04/02/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import UIKit

class DetailMemeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    public var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.meme.memedImage
    }
}
