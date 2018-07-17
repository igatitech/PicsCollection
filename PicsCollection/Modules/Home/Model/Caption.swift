//
//  Caption.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation

public class Caption {
	public var id : String?
	public var text : String?
	public var created_time : String?
	public var from : From?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let caption_list = Caption.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Caption Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Caption]
    {
        var models:[Caption] = []
        for item in array
        {
            models.append(Caption(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let caption = Caption(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Caption Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		text = dictionary["text"] as? String
		created_time = dictionary["created_time"] as? String
        if let fromData = dictionary["from"] as? NSDictionary  {
            from = From(dictionary: fromData)
        }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.text, forKey: "text")
		dictionary.setValue(self.created_time, forKey: "created_time")
		dictionary.setValue(self.from?.dictionaryRepresentation(), forKey: "from")

		return dictionary
	}

}
