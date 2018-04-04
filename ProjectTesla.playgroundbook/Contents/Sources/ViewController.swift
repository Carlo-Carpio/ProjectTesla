//  ViewController.swift
//
//  Created by Carlo Carpio on 21/03/2018.
//  Copyright © 2018 Carlo Carpio. All rights reserved.
//

import UIKit
import PlaygroundSupport

@objc(ViewController)
public class ViewController: UIViewController {
    
    //--MARK: Outlets
    @IBOutlet weak public var upperView: UIView!
    @IBOutlet weak public var label: UILabel! 
    @IBOutlet weak public var componentCollectionView: UICollectionView!
    
    public let componentArray = ComponentsSingleton.shared.componentArray
    public var selectedComponent: Component?
    

    //--MARK: Override
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.componentCollectionView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        componentCollectionView.reloadData()
        
        }


    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.layoutIfNeeded()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        UIView.animate(withDuration: 0.2) {
            self.componentCollectionView.reloadData()
        }
    }

}

//--MARK: collectionView Delegate and DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("componentCollectionView: \(componentArray.count)")
        return componentArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Indexpath.row: \(indexPath.row)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "componentCell", for: indexPath) as! ComponentCollectionViewCell
        cell.config(forComponent: componentArray[indexPath.row])
       
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ComponentCollectionViewCell
        selectedComponent = cell.currentComponent
        
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let componentDetail = sb.instantiateViewController(withIdentifier: "componentDetail") as! ComponentDetailsViewController
        
        componentDetail.passedItem = selectedComponent
        componentDetail.passedIndex = indexPath
        print(componentDetail.passedIndex)
        
        present(componentDetail, animated: true, completion: nil)
        
    }
    
}

//--MARK: FlowLayout delegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 3 , height: collectionView.frame.height / 3 )
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

