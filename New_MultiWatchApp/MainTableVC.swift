//
//  MainTableVC.swift
//  CsvReadSample
//
//  Created by Master on 6/26/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import SwiftCSV

class cityViewCell: UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //City name
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(17)
        return label
    }()
    //Address
    
    let addrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(12)
        return label
    }()
    func setupView()
    {
        addSubview(nameLabel)
        addSubview(addrLabel)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[v0]-3-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": addrLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": addrLabel]))
        
    }
}



class MainTableVC: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    private let cellID = "cityCell"
    
    var cities: [String] = []
    var sortedCities: [[String]] = []
    var cityAddr: [String] = []
    var sortedCityAddr: [[String]] = []
    var sectionName: [String] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var filteredCities: [String] = []
    var filteredCityAddr: [String] = []
    var filteredSectionTitle: [String] = []
    var sortedFilteredCities: [[String]] = []
    var sortedFilteredCityAddr: [[String]] = []
    
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

        self.navigationItem.title = "Select a city"
        self.readCSV()
        //search controller
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        self.searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView?.addSubview(self.searchController.searchBar)
        
        
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        self.extendedLayoutIncludesOpaqueBars = true
        self.tableView = UITableView(frame: self.view.frame, style: .Grouped)
        self.tableView.registerClass(cityViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.estimatedRowHeight = 50
    }
    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        self.searchController.active = false
//        self.tableView.reloadData()
//    }
    
    //Search
    func filterContentForSearchText(searchText: String, scope: String = "All")
    {
        filteredCities.removeAll(keepCapacity: false)
        filteredCityAddr.removeAll(keepCapacity: false)
        if searchText != ""{
            filteredCities = self.cities.filter({ (city) -> Bool in
                return city.lowercaseString.containsString(searchText.lowercaseString)
            })
            filteredCities = filteredCities.sort({ (a, b) -> Bool in
                return a < b
            })
            for cIndex in 0..<filteredCities.count
            {
                for dIndex in 0..<self.cities.count
                {
                    if filteredCities[cIndex] == self.cities[dIndex]
                    {
                        self.filteredCityAddr.append(self.cityAddr[dIndex])
                    }
                }
            }
            (self.sortedFilteredCities, self.sortedFilteredCityAddr) = self.sortData(self.filteredCities, data1: self.filteredCityAddr)
            self.tableView.reloadData()
        }
    }

    func readCSV()
    {
        let csvURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("newCities", ofType: "csv")!)
        do {
            let csv = try CSV(url: csvURL)
            self.cities = csv.columns["Name"]!
            self.cityAddr = csv.columns["Address"]!
            (self.sortedCities, self.sortedCityAddr) = self.sortData(self.cities, data1: self.cityAddr)
            self.tableView.reloadData()
        }catch let error as NSError{
            print("Error in reading CSV: \(error.localizedDescription)")
        }
    }
    func sortData(data: [String], data1:[String]) -> ([[String]],[[String]])
    {
        if data.count == 0 && data1.count == 0{
            self.filteredSectionTitle.removeAll(keepCapacity: false)
            self.sortedFilteredCities.removeAll(keepCapacity: false)
            self.sortedFilteredCityAddr.removeAll(keepCapacity: false)
            self.filteredSectionTitle.removeAll(keepCapacity: false)
            return ([],[])
        }
        if self.searchController.active{
            self.filteredSectionTitle.removeAll(keepCapacity: false)
            self.sortedFilteredCities.removeAll(keepCapacity: false)
            self.sortedFilteredCityAddr.removeAll(keepCapacity: false)
            self.filteredSectionTitle.removeAll(keepCapacity: false)
        }else{
            self.sectionName.removeAll(keepCapacity: false)
        }
        var retData:[[String]] = []
        var retData1:[[String]] = []
        var value:[String] = []
        var value1:[String] = []
        var key: String!
        
        for cIndex in 1...data.count
        {
            if cIndex != data.count{
                let item = data[cIndex]
                let preItem = data[cIndex-1]
                let Alpha = String(item[item.startIndex.advancedBy(0)])
                let preAlpha = String(preItem[preItem.startIndex.advancedBy(0)])
                key = preAlpha
                if Alpha > preAlpha{
                    value.append(data[cIndex-1])
                    value1.append(data1[cIndex-1])
                    retData.append(value)
                    retData1.append(value1)
                    value.removeAll(keepCapacity: false)
                    value1.removeAll(keepCapacity: false)
                    if searchController.active{
                        self.filteredSectionTitle.append(key)
                    }else{
                        self.sectionName.append(key)
                    }
                    key = Alpha
                    
                }else{
                    value.append(data[cIndex-1])
                    value1.append(data1[cIndex-1])
                }
            }else{
                let item = data[cIndex-1]
                if data.count == 1{
                    key = String(item[item.startIndex.advancedBy(0)])
                }
                value.append(data[cIndex-1])
                value1.append(data1[cIndex-1])
                retData.append(value)
                retData1.append(value1)
                value.removeAll(keepCapacity: false)
                value1.removeAll(keepCapacity: false)
                if searchController.active{
                    self.filteredSectionTitle.append(key)
                }else{
                    self.sectionName.append(key)
                }
            }
        }
        
        
        
        return (retData, retData1)
    }
    //Updating the data
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.searchController.active && searchController.searchBar.text != ""{
            if self.filteredSectionTitle.count == 0{
                return 1
            }
            return self.filteredSectionTitle.count
        }
        return self.sectionName.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != ""{
            if self.filteredSectionTitle.count == 0{
                return 1
            }
            return self.sortedFilteredCities[section].count
        }
        return self.sortedCities[section].count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! cityViewCell

        // Configure the cell...
        if self.searchController.active && self.filteredSectionTitle.count == 0{
            cell.nameLabel.text = "No result"
            cell.addrLabel.text = ""
        }else{
            var dispCityData: [[String]] = []
            var dispCityAddrData: [[String]] = []
            dispCityData = searchController.active && searchController.searchBar.text != "" ? self.sortedFilteredCities:self.sortedCities
            dispCityAddrData = searchController.active && searchController.searchBar.text != "" ? self.sortedFilteredCityAddr:self.sortedCityAddr
            cell.nameLabel.text = dispCityData[indexPath.section][indexPath.row]
            cell.addrLabel.text = dispCityAddrData[indexPath.section][indexPath.row]
        }
        return cell
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.searchController.active && self.searchController.searchBar.text != "" {
            if self.filteredSectionTitle.count != 0{
                return self.filteredSectionTitle[section]
            }else{
                return ""
            }
        }else{
            return self.sectionName[section]
        }
    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if searchController.active && searchController.searchBar.text != ""{
            if self.filteredSectionTitle.count != 0{
                return "\(self.sortedFilteredCities[section].count) cities"
            }else{
                return ""
            }
        }else{
            return "\(self.sortedCities[section].count) cities"
        }
    }
    //pagination in tableview
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        if searchController.active && searchController.searchBar.text != ""{
            return self.filteredSectionTitle
        }else{
            return self.sectionName
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
extension MainTableVC
{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}