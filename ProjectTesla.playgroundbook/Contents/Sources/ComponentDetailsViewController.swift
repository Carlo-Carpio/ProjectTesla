//
//  ComponetDetailsViewController.swift
//  WWDC18_Test
//
//  Created by Carlo Carpio on 21/03/2018.
//  Copyright © 2018 Carlo Carpio. All rights reserved.
//

import UIKit
import PlaygroundSupport

@objc (ComponentDetailsViewController)
public class ComponentDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var electricsArray = ComponentsSingleton.shared.componentArray
    
    @IBOutlet public weak var pageControl: UIPageControl!
    @IBOutlet public weak var componentDetailsCollectionView: UICollectionView!
    
    public var passedItem: Component?
    public var passedIndex: IndexPath!
    
    
    //--MARK: Override
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        componentDetailsCollectionView.delegate = self
        componentDetailsCollectionView.dataSource = self
        pageControl.currentPage = passedIndex.row
        pageControl.isHidden = true
    }
    
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        componentDetailsCollectionView.alpha = 0.0
        componentDetailsCollectionView.reloadData()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.componentDetailsCollectionView.selectItem(at: self.passedIndex, animated: false, scrollPosition: UICollectionViewScrollPosition.left)
        UIView.animate(withDuration: 0.2) {
            self.componentDetailsCollectionView.alpha = 1.0
        }
        
    }
    
    @IBAction func onCloseButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    //--MARK: collectionView methods
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return electricsArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectiomn indexpath")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCell", for: indexPath) as! ComponentDetailsCollectionViewCell
        cell.componentDetailsImage.image = nil
        cell.config(forComponent: electricsArray[indexPath.row])
        print("config")
        return cell
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let elementWidth = self.view.bounds.width
        let elementSpacing = CGFloat(0)
        
        let pageWidth = Float(elementWidth + elementSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(componentDetailsCollectionView.contentSize.width  )
        var nextPage = Float(self.pageControl.currentPage)
        
        if velocity.x == 0 {
            nextPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            nextPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if nextPage < 0 {
                nextPage = 0
            }
            if (nextPage > contentWidth / pageWidth) {
                nextPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        self.pageControl.currentPage = Int(nextPage)
        let point = CGPoint (x: CGFloat(nextPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        
    }
    
    // --MARK: collectionView Flow Layout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        componentDetailsCollectionView.reloadData()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.frame.width < collectionView.frame.height {
            return collectionView.bounds.size
        }
        else {
            return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    
}
