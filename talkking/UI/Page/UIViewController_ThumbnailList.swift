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

class UIViewController_ThumbnailList: UIViewController {
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet var Thumbnail: ImageSlideshow!
    
    var ThumbnailURLList : [String] = [String]()
    
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
        
        var thumbnailSource : [KingfisherSource] = [KingfisherSource]()
        for i in 0..<ThumbnailURLList.count
        {
            thumbnailSource.append(KingfisherSource(urlString:ThumbnailURLList[i])!)
        }

        Thumbnail.setImageInputs(thumbnailSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController_ThumbnailList.didTap))
        Thumbnail.addGestureRecognizer(recognizer)
    }
    
    @objc func didTap() {
        let fullScreenController = Thumbnail.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    public func SetUserThumbnailList(userData:UserData)
    {
        ThumbnailURLList = userData.GetThumbnailList()
    }
}
