//
//  SettingTVC.swift
//  multiWatchApp
//
//  Created by Master on 6/21/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit



class SettingTVC: UITableViewController{

    
    @IBAction func btn_add_cities(sender: AnyObject) {
        if self.secSectionTitle.count == 4 {
            msgBox(self, title: "Preference Filled", message: "Four cities have already been selected. Please, remove on to add a different city.")
        }
//        let citiesView = self.storyboard?.instantiateViewControllerWithIdentifier("citiesView") as! CityTVC
        let citiesView = self.storyboard?.instantiateViewControllerWithIdentifier("citiesView") as! MainTableVC
        self.navigationController?.pushViewController(citiesView, animated: true)
    }
    @IBAction func btn_done_tapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var secSectionTitle: [String] = ["Colors", "24-Hour Time", "Disable Auto-Lock"]
    var thdSectionTitle: [String] = ["Instruction", "About"]
    
    private let cellID = "sCell"

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Setting"
        self.tableView = UITableView(frame: self.view.frame, style: .Grouped)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.tableView.scrollEnabled = false
        self.addCityBtn()
      
    }

    //add + buttong for adding city
    func addCityBtn()
    {
        let addCity = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(SettingTVC.addCityBtnTapped(_:)))
        self.navigationItem.rightBarButtonItem = addCity
    }
    
    func addCityBtnTapped(sender: UIBarButtonItem)
    {
        print("Add City btn tapped")
        let cityList = MainTableVC()
        self.navigationController?.pushViewController(cityList, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sCell", forIndexPath: indexPath)

        // Configure the cell...
        switch indexPath.section {
        case 1:
            cell.textLabel?.text = self.secSectionTitle[indexPath.row]
        case 2:
            cell.textLabel?.text = self.thdSectionTitle[indexPath.row]
        default:
            cell.textLabel?.text = "City: \(indexPath.row)"
        }

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            if indexPath.row == 0{                
                let colorsView = CollectionVC(collectionViewLayout: UICollectionViewLayout())
                //getting stored selected color number
                if let colorIndex = keyChainManager.get("selectedColor") {
                    colorsView.selectedItem = Int(colorIndex)
                }else{
                    colorsView.selectedItem = 0
                }
                self.navigationController?.pushViewController(colorsView, animated: true)
            }
        case 2:
            switch indexPath.row {
            case 0:
                let helpView = HelpVC()
                helpView.view.backgroundColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1)
                self.navigationController?.pushViewController(helpView, animated: true)
            case 1:
                let aboutView = AboutVC()
                aboutView.view.backgroundColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1)
                self.navigationController?.pushViewController(aboutView, animated: true)
            default:
                break
            }
            
        default:
            break
        }        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SettingTVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}