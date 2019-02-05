//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by terced-leonardoo on 04/02/19.
//  Copyright © 2019 OKraciunas. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageText: UILabel!
    
    private let reuseIdentifier = "MemeCollectionCell"
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTabBarController(memes: self.appDelegate.memes)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.memes = self.appDelegate.memes
        self.showTabBarController(memes: self.memes)
        self.tableView.reloadData()
    }
    
    // MARK - Mostrando/escondendo mensagem inicial
    
    private func showTabBarController(memes: [Meme]) {
        if self.memes.count == 0 {
            self.tableView.isHidden = true
            self.tabBarController?.tabBar.isHidden = true
            self.messageText.isHidden = false
        }
        else {
            self.tableView.isHidden = false
            self.tabBarController?.tabBar.isHidden = false
            self.messageText.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "\(meme.topText!)...\(meme.bottomText!)"
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailMeme") as! DetailMemeViewController
        detailVC.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func showCreateMemeView(_ sender: UIBarButtonItem) {
        let createMemeVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateMeme") as! CreateMemeViewController
        self.present(createMemeVC, animated: true, completion: nil)
    }
}
