//
//  UserData.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation

public class UserData {
	public var id : String?
	public var user : User?
	public var images : Images?
	public var created_time : String?
	public var caption : Caption?
	public var user_has_liked : Bool?
	public var likes : Likes?
	public var tags : Array<String>?
	public var filter : String?
	public var comments : Comments?
	public var type : String?
	public var link : String?
	public var location : String?
	public var attribution : String?
	public var users_in_photo : Array<String>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = UserData.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of UserData Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [UserData]
    {
        var models:[UserData] = []
        for item in array
        {
            models.append(UserData(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let user_data = UserData(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Data Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
        if let userData = dictionary["user"] as? NSDictionary  {
            user = User(dictionary: userData)
        }
        if let imageData = dictionary["images"] as? NSDictionary  {
            images = Images(dictionary: imageData)
        }
		created_time = dictionary["created_time"] as? String
        if let captionData = dictionary["caption"] as? NSDictionary  {
            caption = Caption(dictionary: captionData)
        }
		user_has_liked = dictionary["user_has_liked"] as? Bool
        if let likesData = dictionary["likes"] as? NSDictionary  {
            likes = Likes(dictionary: likesData)
        }
		filter = dictionary["filter"] as? String
        if let commentsData = dictionary["comments"] as? NSDictionary  {
            comments = Comments(dictionary: commentsData)
        }
		type = dictionary["type"] as? String
		link = dictionary["link"] as? String
		location = dictionary["location"] as? String
		attribution = dictionary["attribution"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.user?.dictionaryRepresentation(), forKey: "user")
		dictionary.setValue(self.images?.dictionaryRepresentation(), forKey: "images")
		dictionary.setValue(self.created_time, forKey: "created_time")
		dictionary.setValue(self.caption?.dictionaryRepresentation(), forKey: "caption")
		dictionary.setValue(self.user_has_liked, forKey: "user_has_liked")
		dictionary.setValue(self.likes?.dictionaryRepresentation(), forKey: "likes")
		dictionary.setValue(self.filter, forKey: "filter")
		dictionary.setValue(self.comments?.dictionaryRepresentation(), forKey: "comments")
		dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.link, forKey: "link")
		dictionary.setValue(self.location, forKey: "location")
		dictionary.setValue(self.attribution, forKey: "attribution")

		return dictionary
	}

}
