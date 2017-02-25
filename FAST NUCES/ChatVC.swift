//
//  ChatVC.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

class ChatVC: JSQMessagesViewController {

    var count = 0
    var message = [JSQMessage]()
    var avatarDict = [String: JSQMessagesAvatarImage]()
    var postId: String!
    let msgRef = FIRDatabase.database().reference().child("messages")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(postId)
        self.title = "Chat Room"
        
        if let currentUser = FIRAuth.auth()?.currentUser
        {
            self.senderId = currentUser.uid
            self.senderDisplayName = "Anonymous"
        }
   
        collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: 38, height:38 )
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: 38, height:38 )
        
        observeMEssage()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.backgroundView =  UIImageView(image: UIImage(named: "main"))
        
    }
    
    
    func observeMEssage()
    {
        DataService.instance.FetchMsg(postId: postId) { (snap) in
            
            
            self.count = self.count + Int(snap.childrenCount)/2
            DataService.instance.RECENT_REF.child(self.postId).child("comments").setValue(self.count)
            if let dict = snap.value as? [String:AnyObject]
            {
                
                let senderId = dict["senderId"] as! String
                self.observeUser(id: senderId)
                let name : String = ""
                let text = dict["message"] as? String
                self.message.append(JSQMessage(senderId: senderId, displayName: name, text: text))
                ProgressHUD.dismiss()
                self.collectionView.reloadData()
               
            }
            
           
        }
        
       
        
    }
    
    
    func observeUser(id:String)
    {
        
        AuthService.instance.USERS_REF?.child(id).observe(.value, with: { (snapshot) in
            let dict = snapshot.value as! Dictionary<String,AnyObject>
            let imageUrl = dict["profileImg"] as! String
            let fileUrl = NSURL(string: imageUrl)
            let data = NSData(contentsOf: fileUrl as! URL)
            let image = UIImage(data: data as! Data)
            let userImg = JSQMessagesAvatarImageFactory.avatarImage(with: image, diameter: 80)
            self.avatarDict[id] = userImg
            self.collectionView.reloadData()
            
        })
        
        
    }
   
    
    func cancel()
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        if let user = FIRAuth.auth()?.currentUser
        {
            DataService.instance.CreateMsg(useruid: user.uid, postId: postId, content: text)
        }
        view.endEditing(true)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        self.finishSendingMessage()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return message[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubblefactory = JSQMessagesBubbleImageFactory()
        let message = self.message[indexPath.item]
        if message.senderId == self.senderId
        {
            
            return bubblefactory?.outgoingMessagesBubbleImage(with: UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3))
        }
        else
        {
            return bubblefactory?.incomingMessagesBubbleImage(with: UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 0.3))
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = self.message[indexPath.item]
        return avatarDict[message.senderId]
        
    }
    
    

}
