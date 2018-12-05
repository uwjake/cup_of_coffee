//
//  MasterViewController.swift
//  cup_of_tea
//
//  Created by Jake Jin on 11/28/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Dictionary<String, Any>]()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadData() {
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        db.collection("users").whereField("gender", isEqualTo: "male")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        UserProfile.sharedInstance.peopleList.append(document.data())
                    }
                }
                self.objects = UserProfile.sharedInstance.peopleList
                self.tableView.reloadData()
//                print(self.objects)
        }

    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        // if not set up, run code below to set up screens
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GetStartedViewController")
//        self.present(nextViewController, animated:true, completion:nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
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
               
                if let imagefromCache = imageCache.object(forKey: url as AnyObject) as? UIImage
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
                                self.imageCache.setObject(imagetoCache!, forKey: url as AnyObject)
                                cell.profilePicture.image = imagetoCache
                                
                            }
                        }).resume()
                    }
                 
                }
        }
        cell.name?.text = objects[indexPath.row]["first_name"] as? String
        cell.accessoryType = .disclosureIndicator
//        cell.profilePicture?.imageFromURL(urlString:  objects[indexPath.row]["profile_picture"] as? String ?? "", PlaceHolderImage: UIImage.init(named: "profile_picture_placeholder")!)
//        print(objects[indexPath.row])
        return cell
    }
    
}
//
//extension UIImageView {
//
//    public func imageFromURL(urlString: String, PlaceHolderImage:UIImage) {
//
//        if self.image == nil{
//            self.image = PlaceHolderImage
//        }
//
//        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
//
//            if error != nil {
//                print(error ?? "No Error")
//                return
//            }
//            DispatchQueue.main.async(execute: { () -> Void in
//                let image = UIImage(data: data!)
//                self.image = image
//            })
//
//        }).resume()
//    }}

//extension UIImageView {
//    var isPortrait:  Bool    { return size.height > size.width }
//    var isLandscape: Bool    { return size.width > size.height }
//    var breadth:     CGFloat { return min(size.width, size.height) }
//    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
//    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
//    var squared: UIImage? {
//        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
//        defer { UIGraphicsEndImageContext() }
//        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
//        UIImage(cgImage: cgImage).draw(in: breadthRect)
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}
