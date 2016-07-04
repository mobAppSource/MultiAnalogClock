//
//  AlarmVC.swift
//  multiWatchApp
//
//  Created by Master on 6/24/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class AlarmVC: UITableViewController {

    @IBAction func btn_done_tapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var swt_alarm_enabled: UISwitch!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBAction func segCityAction(sender: UISegmentedControl) {
        print("Selected: \(sender.selectedSegmentIndex)")
    }
    @IBAction func timePckChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        let timeStr = dateFormatter.stringFromDate(sender.date)
        keyChainManager.set(timeStr, forKey: "setTime")
        print("Selected time: \(sender.date): \(timeStr)")
    }
   
    @IBOutlet weak var txt_alarm_title: UILabel!
    
    
    var isAlarmEnabled = false
    
    //MARK: -
    //MARK: ViewWillAppear
    //MARK: -
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //getting the previous alarm music set from userdefault.
        if let numberStr = keyChainManager.get("songNumber") as String!{
            self.txt_alarm_title.text = songs[Int(numberStr)!]
        }
        // get the previous alarm time from userdefault parameters
        if let timeStr = keyChainManager.get("setTime"){
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            self.timePicker.date = dateFormatter.dateFromString(timeStr)!
            self.timePicker.locale = NSLocale(localeIdentifier: "da_DK")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Alarm Setting"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && indexPath.row == 1{
            if self.isAlarmEnabled{
                self.swt_alarm_enabled.on = false
                self.isAlarmEnabled = !self.isAlarmEnabled
            }else{
                self.swt_alarm_enabled.on = true
                self.isAlarmEnabled = !self.isAlarmEnabled
            }
            
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alarmCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = "Alarm Setting: \(indexPath.row)"
        return cell
    }
    */
    

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
extension AlarmVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}