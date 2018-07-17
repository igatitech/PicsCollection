//
//  Likes.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
 
public class Likes {
	public var count : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let likes_list = Likes.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Likes Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Likes]
    {
        var models:[Likes] = []
        for item in array
        {
            models.append(Likes(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let likes = Likes(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Likes Instance.
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
