//
//  UIViewController_Home.swift
//  talkking
//
//  Created by mangomilk114 on 2018. 5. 1..
//  Copyright © 2018년 도호소프트. All rights reserved.
//

import Foundation
import UIKit
import Parchment

class UIViewController_Home : UIViewController
{
    @IBAction func FilterAction(_ sender: Any) {
    }
    @IBAction func RandomBoxAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MY_JEWEL_PAGE") as! UIViewController_MyJewel
        self.present(page, animated: true)
    }
    @IBAction func HeartRecvAction(_ sender: Any) {
        /*let page = self.storyboard?.instantiateViewController(withIdentifier: "RECV_HEART_PAGE") as! UIViewController_RecvHeartPage
        self.present(page, animated: true)
        if let myData = DataMgr.Instance.MyData
        {
            myData.NewRecvHeartList = false
        }
        
        self.RefreshUI()*/
        
        
         //let page = self.storyboard?.instantiateViewController(withIdentifier: "INPUT_PAGE") as! UIViewController_InputPage
         //self.present(page, animated: true)
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "CHATTING_PAGE") as! UIViewController_Chatting
        self.present(page, animated: true)
        
    }
    @IBOutlet var NewHeartRecv: UIImageView!
    @IBAction func MyPageAction(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MY_USER_PAGE") as! UIViewController_MyUserPage
        self.present(page, animated: true)
    }
    
    let PageTitles = [
        "HOT",
        "인기순",
        "팬보유수",
        "가까운순",
        "NEW",
    ]
    
    let PagingViewController = FixedPagingViewController(viewControllers: [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MAIN_HOME_HOT"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MAIN_HOME_PUBLIC"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MAIN_HOME_FAN_COUNT"),
         UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MAIN_HOME_NEAR"),
         UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MAIN_HOME_NEW")
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PagingViewController.dataSource = self
        PagingViewController.backgroundColor = CommonUIFunc.Instance.GetDefaultColor()
        PagingViewController.selectedBackgroundColor = CommonUIFunc.Instance.GetDefaultColor()
        PagingViewController.indicatorColor = .white
        PagingViewController.textColor = UIColor(white: 1, alpha: 0.6)
        PagingViewController.selectedTextColor = .white
        PagingViewController.menuItemSize = .sizeToFit(minWidth: 20, height: 40)
        
        PagingViewController.indicatorOptions = .visible(
            height: 4,
            zIndex: Int.max,
            spacing: UIEdgeInsets.zero,
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChildViewController(PagingViewController)
        view.addSubview(PagingViewController.view)
        view.constrainToEdges(PagingViewController.view)
        PagingViewController.didMove(toParentViewController: self)
        
        NewHeartRecv.layer.cornerRadius = NewHeartRecv.frame.size.width / 2
        NewHeartRecv.clipsToBounds = true
        CommonUIFunc.MainViewController = self
        RefreshUI()
    }
    
    public func RefreshUI()
    {
        if let myData = DataMgr.Instance.MyData
        {
            if myData.NewRecvHeartList
            {
                NewHeartRecv.isHidden = false
            }
            else
            {
                NewHeartRecv.isHidden = true
            }
        }
    }
}

extension UIViewController_Home: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return PagingIndexItem(index: index, title: self.PageTitles[index]) as! T
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        return self.PagingViewController.viewControllers[index]
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return self.PagingViewController.viewControllers.count
    }
    
}


extension UIView {
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 70)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
}
