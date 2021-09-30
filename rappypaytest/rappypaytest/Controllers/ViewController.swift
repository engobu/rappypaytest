//
//  ViewController.swift
//  rappypaytest
//
//  Created by Enar GoMez on 24/09/21.
//

import UIKit

class ViewController: UITabBarController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrItemSearch: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        self.setItemTitles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setItemTitles() -> Void {
       
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        UITabBar.appearance().tintColor = UIColor.black
        
        let tabBar = self.tabBar
        let items = tabBar.items
        
        let iconMovie = UITabBarItem(title: "Peliculas", image: UIImage(named: "ic_movie"), selectedImage: UIImage(named: "ic_movie"))
        items![0].title = "Peliculas"
        let iconSerie = UITabBarItem(title: "Series", image: UIImage(named: "ic_tv"), selectedImage: UIImage(named: "ic_tv"))
        items![1].title = "Series"
        
        ((self.viewControllers![0] as! UINavigationController).viewControllers[0] as! CommonViewController).programtype = .Movie
        ((self.viewControllers![0] as! UINavigationController).viewControllers[0] as! CommonViewController).tabBarItem = iconMovie
        ((self.viewControllers![1] as! UINavigationController).viewControllers[0] as! CommonViewController).programtype = .Serie
        ((self.viewControllers![1] as! UINavigationController).viewControllers[0] as! CommonViewController).tabBarItem = iconSerie
        
    }
    
}

extension ViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
