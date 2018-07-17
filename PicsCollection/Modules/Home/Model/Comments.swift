//
//  Comments.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation

public class Comments {
	public var count : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let comments_list = Comments.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Comments Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Comments]
    {
        var models:[Comments] = []
        for item in array
        {
            models.append(Comments(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let comments = Comments(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Comments Instance.
*/
	required public init?(dictionary: NSDictionary) {

		count = dictionary["count"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.count, forKey: "count")

		return dictionary
	}

}
