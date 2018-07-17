//
//  Standard_resolution.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
 
public class Standard_resolution {
	public var width : Int?
	public var height : Int?
	public var url : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let standard_resolution_list = Standard_resolution.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Standard_resolution Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Standard_resolution]
    {
        var models:[Standard_resolution] = []
        for item in array
        {
            models.append(Standard_resolution(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let standard_resolution = Standard_resolution(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Standard_resolution Instance.
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
