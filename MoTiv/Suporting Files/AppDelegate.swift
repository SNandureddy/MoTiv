//
//  AppDelegate.swift
//  MoTiv
//
//  Created by Apple on 17/09/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKLoginKit
import TwitterKit
import GoogleMaps
import GooglePlaces
import UserNotifications
import AVKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var net = NetworkReachabilityManager()
    var transition: CATransition {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.2
        return transition
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        keyboardSetup()
        googleMapsSetup()
        fbSetup(application, didFinishLaunchingWithOptions: launchOptions)
        twitterSetup()
        handleNavigation()
        UITabBar.appearance().barTintColor = UIColor.white
        return true
    }
    
    //MARK: CHECK SOCIAL ALREADY LOGED IN
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if TWTRTwitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: nil)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }


    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
}

//Handle Third Party Setups
extension AppDelegate {
    
    func handleNavigation() {
        UIApplication.shared.statusBarStyle = .lightContent
        if DataManager.accessToken != nil {
            BaseVC.userType = DataManager.role! == 3 ? .organiser: .user
            self.navigateToHome()
        }
    }
    
    func navigateToHome() {
        let mainStoryboard = UIStoryboard.storyboard(storyboard: .Main)
        
        var mainVC = UITabBarController()
        if BaseVC.userType == .user {
            if !DataManager.isFirstTime {
                let storyboard = UIStoryboard(storyboard: .Main)
                let vc = storyboard.instantiateViewController(withIdentifier: kReferalCodeVC ) as! ReferalCodeVC
                let nav = UINavigationController(rootViewController: vc)
                if UIApplication.shared.keyWindow == nil {
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.layer.add(transition, forKey: kCATransition)
                    self.window?.rootViewController = nav
                    self.window?.makeKeyAndVisible()
                    return
                }
                else {
                    UIApplication.shared.keyWindow?.layer.add(transition, forKey: kCATransition)
                    UIApplication.shared.keyWindow?.rootViewController = nav
                    UIApplication.shared.keyWindow?.makeKeyAndVisible()
                    return
                }
            }
            else {
                mainVC = mainStoryboard.instantiateViewController(withIdentifier: kU_TabbarVC) as! U_TabbarVC
            }
        }
        else {
            mainVC = mainStoryboard.instantiateViewController(withIdentifier: kTabBarVC) as! TabBarVC
        }
        let nav = UINavigationController(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        if UIApplication.shared.keyWindow == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.layer.add(transition, forKey: kCATransition)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        else {
            UIApplication.shared.keyWindow?.layer.add(transition, forKey: kCATransition)
            UIApplication.shared.keyWindow?.rootViewController = nav
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }


    func keyboardSetup() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }

    func googleMapsSetup() {
        GMSPlacesClient.provideAPIKey(kGoogleKey)
    }
    
    func fbSetup(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func twitterSetup() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: TW_KEY, consumerSecret: TW_SECRET)
    }
}

extension AppDelegate {
    //using alamofire  rechability class
    func checkNetworkStatus(){
        net?.startListening()
        net?.listener = { status in
            if self.net?.isReachable ?? false {
                
                switch status {
                    
                case .reachable(.ethernetOrWiFi):
                    print("The network is reachable over the WiFi connection")
                    //Push data to server from coredata
                case .reachable(.wwan):
                    print("The network is reachable over the WWAN connection")
                    //Push data to server from coredata
                case .notReachable:
                    print("The network is not reachable")
                    
                case .unknown :
                    print("It is unknown whether the network is reachable")
                    
                }}
        }
        
    }
}