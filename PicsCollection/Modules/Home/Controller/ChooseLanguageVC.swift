//
//  ChooseLanguageVC.swift
//  Demo
//
//  Created by Gati Shah on 18/07/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit

/**
 The purpose of the `ChooseLanguageVC` view controller is to allow user to choose different language.
 
 There's a matching scene in the Home.storyboard file. Go to Interface Builder for details.
 
 The `ChooseLanguageVC` class is a subclass of the `UIViewController`, and it conforms to the `UITableViewDelegate`, `UITableViewDataSource` protocol.
 */

class ChooseLanguageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK:- IBOutlets
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var tableLanguage : UITableView!
    @IBOutlet weak var buttonReset : UIButton!
    
    //MARK:- Properties
    var actionSheet: UIAlertController!
    let availableLanguages = Localize.availableLanguages()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //...Language change observer
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }

    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //...Remove observer
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- IBActions
    
    /**
     This click_Back will be called when user clicks on back button.
     It will redirect user to previous screen
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_buttonBack(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     This click_buttonReset will be called when user clicks on reset button.
     It will reset app language to default language.
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_buttonReset(_ sender: AnyObject) {
        Localize.resetCurrentLanguageToDefault()
        self.tableLanguage.reloadData()
    }
    
    //MARK:- Custom Methods
    
    /**
     setText function is used to localised the screen text on language selection
     
     - Parameter nil
     - Returns: nil
    */
    @objc func setText() {
        
        labelTitle.text = StringConstant.chooseLangauge.localized()
    }
}

//MARK:- TableView Delegate Methods
extension ChooseLanguageVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        cell!.textLabel?.text = Localize.displayNameForLanguage(availableLanguages[indexPath.row])
        cell?.selectionStyle = .none
        if availableLanguages[indexPath.row] == Localize.currentLanguage()
        {
            cell!.accessoryType = .checkmark;
        } else {
            cell!.accessoryType = .none;
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        Localize.setCurrentLanguage(availableLanguages[indexPath.row])
        tableView.reloadData()
    }
}

