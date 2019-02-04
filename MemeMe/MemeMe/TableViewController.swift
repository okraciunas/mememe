//
//  TableViewController.swift
//  MemeMe
//
//  Created by terced-leonardoo on 03/02/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.originalImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
//        detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
//        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func showCreateMemeView(_ sender: UIBarButtonItem) {
        let createMemeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeme") as! CreateMemeViewController
        
        self.present(createMemeVC, animated: true, completion: nil)
    }
}
