//
//  SentMemesCollectionCollectionViewController.swift
//  MemeMe
//
//  Created by terced-leonardoo on 03/02/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {

    private var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.memes.count
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let meme = self.memes[(indexPath as NSIndexPath).item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath)
        // Configure the cell
    
        return cell
    }
}
