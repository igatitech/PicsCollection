//
//  Pagination.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
 
public class Pagination {

    public var next_url : String?
    public var next_max_id : String?
/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let pagination_list = Pagination.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Pagination Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Pagination]
    {
        var models:[Pagination] = []
        for item in array
        {
            models.append(Pagination(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let pagination = Pagination(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Pagination Instance.
*/
	required public init?(dictionary: NSDictionary) {

        next_url = dictionary["next_url"] as? String
        next_max_id = dictionary["ne as! Stringxt_max_id"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()
        dictionary.setValue(self.next_url, forKey: "next_url")
        dictionary.setValue(self.next_max_id, forKey: "next_max_id")
		return dictionary
	}

}
