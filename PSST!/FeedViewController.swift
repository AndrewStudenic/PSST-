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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        //query.includeKey(post)
        query.limit = 25
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts
                self.tableVire.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
            as! PostCell
        
        let posts = post[indexPath.row]
        
        cell.
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = messageField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("the message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
