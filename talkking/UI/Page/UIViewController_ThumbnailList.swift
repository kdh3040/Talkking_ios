//
//  UIViewController_ThumbnailList.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 13..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow
import Kingfisher

/// Input Source to image using Kingfisher
public class KingfisherSource: NSObject, InputSource {
    /// url to load
    public var url: URL
    
    /// placeholder used before image is loaded
    public var placeholder: UIImage?
    
    /// options for displaying, ie. [.transition(.fade(0.2))]
    public var options: KingfisherOptionsInfo?
    
    /// Initializes a new source with a URL
    /// - parameter url: a url to be loaded
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter options: options for displaying
    public init(url: URL, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil) {
        self.url = url
        self.placeholder = placeholder
        self.options = options
        super.init()
    }
    
    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter options: options for displaying
    public init?(urlString: String, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            self.placeholder = placeholder
            self.options = options
            super.init()
        } else {
            return nil
        }
    }
    
    @objc public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.kf.setImage(with: self.url, placeholder: self.placeholder, options: self.options, progressBlock: nil) { (image, _, _, _) in
            callback(image)
        }
    }
    
    public func cancelLoad(on imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
}

/// Input Source to load plain UIImage
@objcMembers
open class ImageSource: NSObject, InputSource {
    var image: UIImage!
    
    /// Initializes a new Image Source with UIImage
    /// - parameter image: Image to be loaded
    public init(image: UIImage) {
        self.image = image
    }
    
    /// Initializes a new Image Source with an image name from the main bundle
    /// - parameter imageString: name of the file in the application's main bundle
    public init?(imageString: String) {
        if let image = UIImage(named: imageString) {
            self.image = image
            super.init()
        } else {
            return nil
        }
    }
    
    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.image = image
        callback(image)
    }
}

class UIViewController_ThumbnailList: UIViewController {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var Thumbnail: ImageSlideshow!
    
    var ThumbnailURLList : [String] = [String]()
    var ThumbnailImageList : [Int:UIImage?] = [Int:UIImage?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Thumbnail.backgroundColor = UIColor.white
        Thumbnail.slideshowInterval = 5.0
        Thumbnail.pageControlPosition = PageControlPosition.underScrollView
        Thumbnail.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        Thumbnail.pageControl.pageIndicatorTintColor = UIColor.black
        Thumbnail.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        Thumbnail.activityIndicator = DefaultActivityIndicator()
        Thumbnail.currentPageChanged = { page in
            print("current page:", page)
        }
        
        if ThumbnailURLList.count > 0
        {
            var thumbnailSource : [KingfisherSource] = [KingfisherSource]()
            for i in 0..<ThumbnailURLList.count
            {
                if ThumbnailURLList[i] != "1"
                {
                    thumbnailSource.append(KingfisherSource(urlString:ThumbnailURLList[i])!)
                }
            }
            
            Thumbnail.setImageInputs(thumbnailSource)
        }
        
        if ThumbnailImageList.count > 0
        {
            var thumbnailSource : [ImageSource] = [ImageSource]()
            for data in ThumbnailImageList
            {
                if let image = data.value
                {
                    thumbnailSource.append(ImageSource.init(image: image))
                }
            }
            Thumbnail.setImageInputs(thumbnailSource)
        }

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController_ThumbnailList.didTap))
        Thumbnail.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
        let fullScreenController = Thumbnail.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    public func SetUserThumbnailList(thumbnailList:[String])
    {
        ThumbnailURLList.removeAll()
        ThumbnailImageList.removeAll()
        ThumbnailURLList = thumbnailList
    }
    
    public func SetUserThumbnailList(userData:UserData)
    {
        ThumbnailURLList.removeAll()
        ThumbnailImageList.removeAll()
        ThumbnailURLList = userData.GetThumbnailList()
    }
    
    public func SetUserThumbnailList(thumbnailList:[Int:UIImage?])
    {
        ThumbnailURLList.removeAll()
        ThumbnailImageList = thumbnailList
    }
}
