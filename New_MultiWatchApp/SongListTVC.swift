//
//  SongListTVC.swift
//  MusicPlayAppSample
//
//  Created by Master on 6/26/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import AVFoundation

class SongListTVC: UITableViewController {

    
    
    var alarmURL: NSURL!
    var alarmPlayer = AVAudioPlayer()
    var songNumber: Int!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let numberStr = keyChainManager.get("songNumber") as String!{
            self.songNumber = Int(numberStr)
            
            self.alarmURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(songs[self.songNumber], ofType: "caf")!)
            do {
                try self.alarmPlayer = AVAudioPlayer(contentsOfURL: self.alarmURL)
                self.alarmPlayer.play()
            } catch {
                print("Player can not play")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Music Player"

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: -
    // MARK: - Table view data source
    // MARK: -

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = songs[indexPath.row]
        cell.accessoryType = (indexPath.row == self.songNumber) ? .Checkmark: .None

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let index = indexPath.row
        print("Selected Song: \(songs[index])")
        self.alarmURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(songs[index], ofType: "caf")!)
        do {
            try self.alarmPlayer = AVAudioPlayer(contentsOfURL: self.alarmURL)
            self.alarmPlayer.play()
            keyChainManager.set("\(index)", forKey: "songNumber")
            self.songNumber = index
            self.tableView.reloadData()
        } catch {
            print("Player can not play")
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
