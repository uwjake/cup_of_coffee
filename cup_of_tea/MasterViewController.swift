//
//  MasterViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CoreLocation

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Dictionary<String, Any>]()
    static var imageCache = NSCache<AnyObject, AnyObject>()
    func getAgeFromTimestamp(dob: Timestamp)->Int {
        let today = Int64(NSDate().timeIntervalSince1970)
        let age = Int ( (today - dob.seconds) / (60*60*24*365) )
        return age
    }
    
    func presentError() {
        let alert = UIAlertController(title: "Failed to load data", message: "Possible reason: no Internet, our database is down.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func loadData() {
          UserProfile.sharedInstance.peopleList = []
//        print("start loading")
        DispatchQueue.main.async
        {
            let db = Firestore.firestore()
            let settings = db.settings
            settings.areTimestampsInSnapshotsEnabled = true
            db.settings = settings
            let myContact = UserDefaults.standard.string(forKey: "my_contact") ?? UserProfile.sharedInstance.userId
           
            db.collection("users").document(myContact).getDocument { (document, error) in
                if let document = document, document.exists {
                    UserProfile.sharedInstance.myProfileData = document.data() as! Dictionary<String, Any>
                    
                    db.collection("users").whereField("gender", isEqualTo: UserProfile.sharedInstance.myProfileData["gender_pref"] as! String)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    //                        print("\(document.documentID) => \(document.data())")
                                    var person = document.data()
                                    let location = person["location"] as! Dictionary<String, Double>
                                    if person["location_visible"] as! Bool {
                                        person["distance"] = self.calDistance(lat: location["lat"]!, lng: location["lng"]!)
                                    } else {
                                        person["distance"] = nil
                                    }
                                    person["age"] = self.getAgeFromTimestamp(dob: person["dob"] as! Timestamp)
                                    UserProfile.sharedInstance.peopleList.append(person)
                                }
                            }
                            self.objects = UserProfile.sharedInstance.peopleList
                            self.tableView.reloadData()
                            //                    print(self.objects)
                    }
                    
                } else {
                    self.presentError()
                }
            }
           
        }
//        print("done loading")

    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        // if not set up, run code below to set up screens
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GetStartedViewController")
//        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
       
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            self.loadData()
            group.leave()
        }
        group.wait()
         
        refreshControl.endRefreshing()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
       
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        loadData()
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentisfier: "PersonTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 125.0
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell else {
            fatalError("The dequeued cell is not an instance of PersonTableViewCell.")
        }
        let url = objects[indexPath.row]["profile_picture"] as! String
        
            if url != ""
            {
                if let imagefromCache = MasterViewController.imageCache.object(forKey: url as AnyObject) as? UIImage
                {
                    cell.profilePicture.image = imagefromCache
                    
                } else {
                    cell.profilePicture.image = nil
                    
                    
                    let urlURL = URL(string: (url))
                    if urlURL != nil {
                        
                        URLSession.shared.dataTask(with: urlURL!, completionHandler: { (data, response, error) in
                            if error != nil
                            {
                                //                        print(error.debugDescription)
                                return
                            }
                            
                            DispatchQueue.main.async {
                                let imagetoCache = UIImage(data:data!)
                                if imagetoCache != nil {
                                    MasterViewController.imageCache.setObject(imagetoCache!, forKey: url as AnyObject)
                                    cell.profilePicture.image = imagetoCache
                                
                                } else {
//                                    print("url failed")
                                    cell.profilePicture.image = UIImage(named: "profile_picture_placeholder")
                                }
                            }
                        }).resume()
                    }
                }
            } else {
//                print("no profile picimgage")
                cell.profilePicture.image = UIImage(named: "profile_picture_placeholder")
            }
        cell.name?.text = objects[indexPath.row]["first_name"] as? String
        cell.age?.text = "\(objects[indexPath.row]["age"] as! Int)"
        if objects[indexPath.row]["distance"] == nil {
            cell.distance?.text = ""
        } else {
            cell.distance?.text = "\(objects[indexPath.row]["distance"]! as! Int) miles away"
        }
        cell.gender?.image = UIImage(named: objects[indexPath.row]["gender"] as? String ?? "gn")
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func calDistance(lat : Double, lng : Double) -> Int {
        let myGeoLocation = UserProfile.sharedInstance.myProfileData["location"] as! Dictionary<String, Double>
        let myLocation = CLLocation(latitude: myGeoLocation["lat"]!, longitude: myGeoLocation["lng"]!)
        let peopleLocation = CLLocation(latitude: lat, longitude: lng)
        let distanceInMiles = myLocation.distance(from: peopleLocation)/1609.344
        return Int(distanceInMiles)
    }
    
}
