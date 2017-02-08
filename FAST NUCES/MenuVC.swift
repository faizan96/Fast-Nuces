

import UIKit
import Spring
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class MenuVC: UITableViewController {
    
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userImg: DesignableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImg.layer.cornerRadius = 60
        userImg.clipsToBounds = true

        let child = FIRAuth.auth()?.currentUser?.uid
        
        AuthService.instance.USERS_REF?.child(child!).observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as? Dictionary<String,AnyObject>
            let imageUrl = dict?["profileImg"] as! String
            let username = dict?["username"] as! String
            self.userLbl.text = username.capitalized
            
            let ImgUrl = NSURL(string: imageUrl)
            DispatchQueue.global(qos: .background).async {
                let ImgData = NSData(contentsOf: ImgUrl! as URL)
                let image = UIImage(data: ImgData! as Data);
                
                DispatchQueue.main.async {
                    self.userImg.image = image
                }
            }
        })
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 4)
        {
         
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            
            
        }
    }



}
