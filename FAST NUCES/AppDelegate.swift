//
//  AppDelegate.swift
//  FAST NUCES
//
//  Created by Faizan on 21/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GoogleSignIn
import ProgressHUD
import GoogleMobileAds



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor	=	UIColor.white
        UINavigationBar.appearance().tintColor	=	UIColor.black
       
        
        if	let	barFont	=	UIFont(name:"Proxima Nova Alt Regular",	size:26.0)	{
            UINavigationBar.appearance().titleTextAttributes	=
                [NSForegroundColorAttributeName:UIColor.white,	NSFontAttributeName:barFont]
        }
        IQKeyboardManager.sharedManager().enable = true
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        FIRApp.configure()
        
        GADMobileAds.configure(withApplicationID: "ca-app-pub-5765623355505954~7005958226")
        
        

        if FIRAuth.auth()?.currentUser != nil
        {
            AuthService.instance.switchNav()
        }
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,annotation: [options[UIApplicationOpenURLOptionsKey.annotation]])
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor Guser: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }
        else
        {
            ProgressHUD.show("Authorizing...")
            print("Successfully loggin with gmail")
            
            guard let authentication = Guser.authentication else { return }
            let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                              accessToken: authentication.accessToken)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error)
                    return
                }
                guard let uid = user?.uid else{ return}
                
                
                AuthService.instance.switchNav()
                print("Google Sign in with Firebase",uid)
                
                let Gname = Guser.profile.name!
                let Gemail = Guser.profile.email!
                print(Gname )
                print(Gemail )
                if Guser.profile.hasImage
                {
                    let picUrl = Guser.profile.imageURL(withDimension: 100)!
                    let pic : String = picUrl.absoluteString
                    AuthService.instance.USERS_REF?.child(uid).setValue(["username":Gname,"email":Gemail,"profileImg":pic])
                }
                
            }
        }
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

