//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 01/12/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
    
    var videos = [Videos]()
    
    var filterSearch = [Videos]()
    
    let resultSearchController = UISearchController(searchResultsController: nil)
    
    
    
    var limit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        

    
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChange() {
        print("The preferred Font has changed")
    }
    
    func didLoadData(_ videos: [Videos]) {
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.red]
        
        title = ("The iTunes Top \(limit) Music Videos")
        
        definesPresentationContext = true
        
        resultSearchController.dimsBackgroundDuringPresentation = false
        
        resultSearchController.searchBar.placeholder = "Search for Artist"
        
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS:
            //view.backgroundColor = UIColor.red
            
            // move back to Main Queue
            DispatchQueue.main.async {
                
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
                action -> () in
                print("Cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                action -> () in
                print ("Delete")
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default) {
                action -> Void in
                print ("Ok")
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true, completion: nil)
            }
        default:
            //view.backgroundColor = UIColor.green
            if videos.count > 0 {
                print ("do not refresh API")
            } else {
                runAPI()
            }
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        runAPI()
    }
    
    
    func getAPICount() {
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            limit = theValue
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyy HH:mm:ss"
        let refreshDate = formatter.string(from: Date())
        refreshControl!.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    func runAPI() {
        
        getAPICount()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    // Is called when the object is about to be deallocated
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "preferredFontChange"), object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive {
            return filterSearch.count
        }
        
        return videos.count
    }

    private struct storyboard {
        static let cellReuseidentifier = "cell"
        static let segueIdentifier = "musicDetail"
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseidentifier, for: indexPath) as! MusicVideoTableViewCell
        
        if resultSearchController.isActive {
            cell.video = filterSearch[indexPath.row]
        } else  {
        
            cell.video = videos[indexPath.row]
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboard.segueIdentifier
        {
            if let indexPath = tableView.indexPathForSelectedRow {
                let video: Videos
                
                if resultSearchController.isActive {
                    video = filterSearch[indexPath.row]
                } else {
                    video = videos[indexPath.row]
                }
                let dvc = segue.destination as! MisicVideoDetailVC
                dvc.videos = video
            }
        }
    }
 

}
