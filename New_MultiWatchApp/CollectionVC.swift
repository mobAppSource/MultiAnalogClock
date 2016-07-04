//
//  CollectionVC.swift
//  TableAndCollection
//
//  Created by Master on 6/28/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cCell"



class CollectionVC: UICollectionViewController {

    
    var wasSelected: [Bool] = []
    var selectedItem: Int!
    var lastIndex: Int!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.view.backgroundColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        // Do any additional setup after loading the view.
//        self.readData()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSizeMake((self.view.frame.size.width - 60)/4, (self.view.frame.size.width - 60)/4)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView!.registerClass(colViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.init_boolValue(self.selectedItem)
    }
    func init_boolValue(index: Int, lastIndex: Int = 0)
    {
        let boolVal = [Bool](count: paletteSet.count, repeatedValue: false)
        self.wasSelected = boolVal
        if self.selectedItem != nil
        {
            self.wasSelected[self.selectedItem] = true
        }
        if lastIndex != 0{
            self.wasSelected[lastIndex] = false
        }
        keyChainManager.set("\(index)", forKey: "selectedColor")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return paletteSet.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! colViewCell
    
        // Configure the cell
        if self.wasSelected[indexPath.item]{
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.redColor().CGColor
            self.wasSelected.append(true)
        }else{
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.blackColor().CGColor
            self.wasSelected.append(false)
        }
        
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        
        
        let wCell = cell.contentView.frame.size.width
        let hCell = cell.contentView.frame.size.height
        let color = paletteSet[indexPath.item]
        
        let fstView = UIView(frame: CGRect(x: 0, y: 0, width: wCell/3, height: hCell))
        fstView.backgroundColor = UIColor(red: CGFloat(color[0][0])/255, green: CGFloat(color[0][1])/255, blue: CGFloat(color[0][2])/255, alpha: 1)
        
        let secView = UIView(frame: CGRect(x: wCell/3, y: 0, width: wCell/3, height: hCell))
        secView.backgroundColor = UIColor(red: CGFloat(color[1][0])/255, green: CGFloat(color[1][1])/255, blue: CGFloat(color[1][2])/255, alpha: 1)
        
        let thdView = UIView(frame: CGRect(x: 2*wCell/3, y: 0, width: wCell/3, height: hCell))
        thdView.backgroundColor = UIColor(red: CGFloat(color[1][0])/255, green: CGFloat(color[2][1])/255, blue: CGFloat(color[2][2])/255, alpha: 1)
        
        //
        cell.contentView.addSubview(fstView)
        cell.contentView.addSubview(secView)
        cell.contentView.addSubview(thdView)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.cellForItemAtIndexPath(indexPath)
//        cell?.layer.borderColor = UIColor.redColor().CGColor
//        cell?.layer.borderWidth = 5
//        cell?.layer.masksToBounds = true
        self.lastIndex = self.selectedItem
        self.selectedItem = indexPath.item
        self.init_boolValue(self.selectedItem, lastIndex: self.lastIndex)
        self.collectionView?.reloadData()
        let colors = paletteSet[indexPath.item]
        fstColor = UIColor(red: CGFloat(colors[0][0]/255), green: CGFloat(colors[0][1]/255), blue: CGFloat(colors[0][2]/255), alpha: 1)
        secColor = UIColor(red: CGFloat(colors[1][0]/255), green: CGFloat(colors[1][1]/255), blue: CGFloat(colors[1][2]/255), alpha: 1)
        thdColor = UIColor(red: CGFloat(colors[2][0]/255), green: CGFloat(colors[2][1]/255), blue: CGFloat(colors[2][2]/255), alpha: 1)
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
extension CollectionVC
{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}


class colViewCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews()
    {
        
    }
    
}
