//
//  PhotoStreamViewController.swift
//  Pinterest
//
//  Created by neal on 2017/9/5.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "AnnotatedPhotoCell"

class PhotoStreamViewController: UICollectionViewController {

    var photos  = Photo.allPhotos()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsetsMake(23, 5, 10, 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PhotoStreamViewController  {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnnotatedPhotoCell
        
        cell.photo = photos[indexPath.item]
        
        return cell
    }
}

extension PhotoStreamViewController {
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}

extension PhotoStreamViewController : PinterestLayoutDelegate {
    // 1 
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let photo = photos[(indexPath as NSIndexPath).row]
        let  boundingRect = CGRect(x: 0, y: 0, width: withWidth, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
        
        return rect.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        let photo = photos[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = photo.heightForComent(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        
        return height
    }
}
