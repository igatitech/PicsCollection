//
//  SideMenu.swift
//  JamboMart
//
//  Created by Gati Shah on 7/15/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import SideMenu
import SDWebImage

/**
 The purpose of the `SideMenu` view controller is to provide navigation options.
 
 There's a matching scene in the Home.storyboard file. Go to Interface Builder for details.
 
 The `SideMenu` class is a subclass of the `UIViewController`, and it conforms to the `UITableViewDatasource`, `UITableViewDelegate` protocol.
 */

class SideMenu : UIViewController{
    
    //MARK:- Outlest
    
    @IBOutlet weak var tableSideMenu: UITableView!
    
    //MARK:- Properties
    
    var arrCategories = [String]()
    var arrCategoryIcons = [String]()

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- Custom Methods
  
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     */
    func SetUpView(){
  
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .subMenu
        
        self.tableSideMenu.separatorStyle = .none
        self.tableSideMenu.tableFooterView = UIView(frame: .zero)
        let nib = UINib(nibName: CellIdentifier.SideMenu, bundle: nil)
        self.tableSideMenu.register(nib, forCellReuseIdentifier: CellIdentifier.SideMenu)
        self.tableSideMenu.reloadData()
        
        arrCategories = [StringSideMenu.appTour.localized(), StringSideMenu.chooseLang.localized(), StringSideMenu.logout.localized()]
        arrCategoryIcons = [StringImages.imgAppTour, StringImages.imgLanguage, StringImages.imgLogout]
    }
    
    //MARK:- API Call
    
    /**
     logoutAPICall function is used to perform logout from the application.
    */
    func logoutAPICall() {
        let alertLogout = UIAlertController.init(title: alerts.title.localized(), message: alerts.logout.localized(), preferredStyle: .alert)
        let actionYes = UIAlertAction.init(title: alerts.yes.localized(), style: .destructive, handler: { (action) in
            NetworkManager.request(viewController: self, showloader: true, url: .Logout, method: .post, parameters: ["":""], success: { (response) in
                isLogout = true
                resetDefaults()
                self.dismiss(animated: true, completion: nil)
            }, failure: {_ in 
            })
        })
        let actionNo = UIAlertAction.init(title: alerts.no.localized(), style: .default, handler: nil)
        alertLogout.addAction(actionYes)
        alertLogout.addAction(actionNo)
        self.present(alertLogout, animated: true, completion: nil)
    }
}

//MARK:- TableView DataSource & Delegate
extension SideMenu : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return SideMenuCell.instanceFromNib().frame.size.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SideMenuHeader.instanceFromNib().frame.size.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SideMenuHeader.instanceFromNib()
        header.vController = self
        
        header.setFullName(strFullname: getStringFromDefaults(key: .fullname) ?? "Full Name")
        header.setUserName(strUserName: getStringFromDefaults(key: .userName) ?? "Username")
        header.imageUser.sd_setImage(with: URL(string: getStringFromDefaults(key: .profilePicture) ?? ""), placeholderImage: UIImage(named: StringImages.imgPlaceholder))
        return header
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : SideMenuCell = self.tableSideMenu.dequeueReusableCell(withIdentifier: CellIdentifier.SideMenu) as! SideMenuCell
        
        cell.setTitleName(strTitle: arrCategories[indexPath.row])
        cell.setIconImage(strImage: arrCategoryIcons[indexPath.row])
        return cell
        
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        SideMenuManager.default.menuPushStyle = .defaultBehavior
        switch indexPath.row {
        case 0:
            guard let objAppTour = GetViewController(StoryBoard: .Home, Identifier: .AppTour) else {
                return
            }
            self.navigationController?.pushViewController(objAppTour, animated: true)
            break
        case 1:
            guard let objChooseLang = GetViewController(StoryBoard: .Home, Identifier: .ChooseLanguage) else {
                return
            }
            self.navigationController?.pushViewController(objChooseLang, animated: true)
        default:
            //...Logout from here
            logoutAPICall()
            break
        }
    }
}


