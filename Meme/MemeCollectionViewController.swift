//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Poseidon Ho on 1/29/16.
//  Copyright © 2016 oi7. All rights reserved.
//

import Foundation
import UIKit

// Collection view for the sent memes
class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var memes: [Meme]!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: -
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Refresh the local memes reference
        memes = MemeManager.sharedInstance.memes
        // Refresh the collection
        collectionView.reloadData()
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        
        let destinationController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetailViewController
        destinationController.meme = meme
        destinationController.memeIndex = indexPath.row
        
        navigationController?.pushViewController(destinationController, animated: true)
    }
    
    // MARK: -
    // MARK: Actions
    
    @IBAction func createMeme(sender: UIBarButtonItem) {
        presentMemeEditor()
    }
    
    // MARK: -
    // MARK: Utilities
    
    func presentMemeEditor() {
        let memeEditorController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
        
        presentViewController(memeEditorController, animated: true, completion: nil)
    }
}