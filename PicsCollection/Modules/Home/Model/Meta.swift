//
//  Meta.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
 
public class Meta {
	public var code : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let meta_list = Meta.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Meta Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Meta]
    {
        var models:[Meta] = []
        for item in array
        {
            models.append(Meta(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let meta = Meta(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Meta Instance.
*/
	required public init?(dictionary: NSDictionary) {

		code = dictionary["code"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.code, forKey: "code")

		return dictionary
	}

}
