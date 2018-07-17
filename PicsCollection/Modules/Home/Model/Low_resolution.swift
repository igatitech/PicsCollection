//
//  Low_resolution.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
 
public class Low_resolution {
	public var width : Int?
	public var height : Int?
	public var url : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let low_resolution_list = Low_resolution.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Low_resolution Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Low_resolution]
    {
        var models:[Low_resolution] = []
        for item in array
        {
            models.append(Low_resolution(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let low_resolution = Low_resolution(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Low_resolution Instance.
*/
	required public init?(dictionary: NSDictionary) {

		width = dictionary["width"] as? Int
		height = dictionary["height"] as? Int
		url = dictionary["url"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.width, forKey: "width")
		dictionary.setValue(self.height, forKey: "height")
		dictionary.setValue(self.url, forKey: "url")

		return dictionary
	}

}
