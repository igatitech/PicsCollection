//
//  MainData.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//
import Foundation
import CollieGallery
 
public class MainData {
	public var pagination : Pagination?
	public var data : Array<UserData>?
	public var meta : Meta?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let MainData_list = MainData.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of MainData Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [MainData]
    {
        var models:[MainData] = []
        for item in array
        {
            models.append(MainData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let MainData = MainData(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: MainData Instance.
*/
	required public init?(dictionary: NSDictionary) {

        if let paginationData = dictionary["pagination"] as? NSDictionary  {
            pagination = Pagination(dictionary: paginationData)
        }
        if let userData = dictionary["data"] as? NSArray  {
            data = UserData.modelsFromDictionaryArray(array: userData)
        }
        if let metaData = dictionary["meta"] as? NSDictionary  {
            meta = Meta(dictionary: metaData)
        }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.pagination?.dictionaryRepresentation(), forKey: "pagination")
		dictionary.setValue(self.meta?.dictionaryRepresentation(), forKey: "meta")

		return dictionary
	}
    
    func getUserImages() -> [CollieGalleryPicture]{
        var Images = [CollieGalleryPicture]()
        for picture in self.data ?? Array() {
            Images.append(CollieGalleryPicture(url: picture.images?.low_resolution?.url ?? ""))
        }
        return Images
    }
}
