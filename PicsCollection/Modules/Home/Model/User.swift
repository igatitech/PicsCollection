//
//  User.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
 
public class User {
	public var id : String?
	public var full_name : String?
	public var profile_picture : String?
	public var username : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let user_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of User Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [User]
    {
        var models:[User] = []
        for item in array
        {
            models.append(User(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let user = User(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: User Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		full_name = dictionary["full_name"] as? String
		profile_picture = dictionary["profile_picture"] as? String
		username = dictionary["username"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.full_name, forKey: "full_name")
		dictionary.setValue(self.profile_picture, forKey: "profile_picture")
		dictionary.setValue(self.username, forKey: "username")

		return dictionary
	}

}
