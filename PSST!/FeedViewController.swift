//
//  FeedViewController.swift
//  PSST!
//
//  Created by ANDREW STUDENIC on 3/7/19.
//  Copyright © 2019 ANDREW STUDENIC. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.order(byDescending: "createdAt")
        query.limit = 25
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
            as! PostCell
        
        let post = posts[indexPath.row]
        
        cell.messageLabel.text = post["text"] as? String
        //cell.usernameLabel.text = post["user"] as? String
        if let user = post["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "🤡"
        }
        
        return cell
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = messageField.text ?? ""
        chatMessage["user"] = PFUser.current()!
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("the message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    /*
     
     Experiment....
     
     
    func getMessages() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error? ) in
            if let posts = posts {
                self.posts = posts
                print("\(String(describing: self.posts.first!["text"]!))")
                self.tableView.reloadData()
            } else {
                print("Error getting messages...")
            }
        
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

