//
//  imageOptClient.swift
//  imageOptClientiOS
//
//  Created by BHAVESH on 18/10/19.
//  Copyright © 2019 imageOpt. All rights reserved.
//

import Foundation

import UIKit
public class imageOptClient: NSObject {
    
    
    @objc class public func constructURL(imageURL:String, imageSize:CGSize, crop:Bool, locale: Locale ) -> URL? {
        let scale = UIScreen.main.scale
        
        if (imageSize.width == 0 && imageSize.height == 0 ) {
            // "Both image width and height cannot be zero"
            return nil
        }
        
        if var components = URLComponents(string:imageURL) {
            components.queryItems = [
                URLQueryItem(name: "w", value: String(Int(imageSize.width*scale))),
                URLQueryItem(name: "h", value: String(Int(imageSize.height*scale))),
            ]
            
            if crop {
                components.queryItems?.append(URLQueryItem(name: "c", value: "true"))
            }
            
            components.queryItems?.append(URLQueryItem(name:"l",value:locale.languageCode))
            
            return components.url;
        }
        return nil
    }
    
    @objc class public func constructURL(imageURL:String, imageSize:CGSize, crop:Bool ) -> URL? {
        let scale = UIScreen.main.scale
        
        if (imageSize.width == 0 && imageSize.height == 0 ) {
            // "Both image width and height cannot be zero"
            return nil
        }
        
        if var components = URLComponents(string:imageURL) {
            components.queryItems = [
                URLQueryItem(name: "w", value: String(Int(imageSize.width*scale))),
                URLQueryItem(name: "h", value: String(Int(imageSize.height*scale))),
            ]
            
            if crop {
                components.queryItems?.append(URLQueryItem(name: "c", value: "true"))
            }
                        
            return components.url;
        }
        return nil
    }
    
    @objc class public func constructURL(imageURL:String, imageSize:CGSize, crop:Bool, useSystemLocale:Bool ) -> URL? {
        if useSystemLocale {
            return constructURL(imageURL: imageURL, imageSize: imageSize, crop: crop, locale: Locale.current)
        }
        else {
            return constructURL(imageURL: imageURL, imageSize: imageSize, crop: crop)
        }
    }
    
    @objc class public func constructURL(imageURL:String, imageView:UIImageView, crop:Bool, locale: Locale, completionHandler: @escaping (_ imageOptURL: URL?) -> Void){
        DispatchQueue.main.async(execute: {() -> Void in
            let imageOptURL = self.constructURL(imageURL: imageURL, imageSize: imageView.frame.size, crop: crop, locale: locale)
            completionHandler(imageOptURL)
        })
    }

    @objc class public func constructURL(imageURL:String, imageView:UIImageView, crop:Bool, completionHandler: @escaping (_ imageOptURL: URL?) -> Void){
        DispatchQueue.main.async(execute: {() -> Void in
            let imageOptURL = self.constructURL(imageURL: imageURL, imageSize: imageView.frame.size, crop: crop)
            completionHandler(imageOptURL)
        })
    }
    
    @objc class public func constructURL(imageURL:String, imageView:UIImageView, crop:Bool, useSystemLocale: Bool, completionHandler: @escaping (_ imageOptURL: URL?) -> Void){
        DispatchQueue.main.async(execute: {() -> Void in
            let imageOptURL = self.constructURL(imageURL: imageURL, imageSize: imageView.frame.size, crop: crop, useSystemLocale: useSystemLocale)
            completionHandler(imageOptURL)
        })
    }
}
