//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by terced-leonardoo on 03/02/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionCell"

class SentMemesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        self.flowLayout.minimumInteritemSpacing = space
        self.flowLayout.minimumLineSpacing = space
        self.flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.memes = self.appDelegate.memes
        self.collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = self.memes[(indexPath as NSIndexPath).item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemeCollectionViewCell
        cell.imageView.image = meme.originalImage
    
        return cell
    }
    
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailMeme") as! DetailMemeViewController
        detailVC.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
     }
    
    @IBAction func showCreateMemeView(_ sender: UIBarButtonItem) {
        let createMemeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeme") as! CreateMemeViewController
        self.present(createMemeVC, animated: true, completion: nil)
    }
}
