//
//  BaseController.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 15/06/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    private var activityView: UIActivityIndicatorView?
    
    func showActivityView() {
        let animationDuration: Double = 0.15
        
        self.activityView = UIActivityIndicatorView(style: .whiteLarge)
        self.activityView?.color = .black
        self.activityView?.alpha = .zero
        
        self.view.addSubview(self.activityView!)
        self.activityView?.centeringConstraints(centerXAnchor: self.view.safeAreaLayoutGuide.centerXAnchor,
                                                centerYAnchor: self.view.safeAreaLayoutGuide.centerYAnchor)
        
        self.activityView?.startAnimating()
        UIView.animate(withDuration: animationDuration) {
            self.activityView?.alpha = .one
        }
    }
    
    func hideActivityView() {
        let animationDuration: Double = 0.15
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.activityView?.alpha = .zero
        }) { _ in
            self.activityView?.stopAnimating()
            self.activityView?.removeFromSuperview()
            self.activityView = nil
        }
    }
    
    func showErrorAlert() {
        let alertView = UIAlertController(title: "Ooops, something went wrong.",
                                          message: "We could not load any posts. Please check your internet connection and try again.",
                                          preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .cancel) { _ in
            alertView.dismiss(animated: true)
        }
        alertView.addAction(okayAction)
        self.present(alertView, animated: true)
    }
}
