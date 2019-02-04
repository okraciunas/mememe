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

    private var memes = [Meme]()
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        self.flowLayout.minimumInteritemSpacing = space
        self.flowLayout.minimumLineSpacing = space
        self.flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
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
        // Grab the DetailVC from Storyboard
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
        
        //Populate view controller with data from the selected item
//        detailController.villain = allVillains[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
//        navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func showCreateMemeView(_ sender: UIBarButtonItem) {
        let createMemeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeme") as! CreateMemeViewController
        
        self.present(createMemeVC, animated: true, completion: nil)
    }
}
