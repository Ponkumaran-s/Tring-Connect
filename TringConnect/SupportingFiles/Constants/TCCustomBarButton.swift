//
//  TCCustomBarButton.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

class CustomBarButton: UIBarButtonItem
{
    // Unread Mark
    private var unreadMark: CAShapeLayer?
    
    // Keep track of unread status
    var hasUnread: Bool = false
    {
        didSet
        {
            setUnread(hasUnread: hasUnread)
        }
    }
    
    // Toggles unread status
    private func setUnread(hasUnread: Bool)
    {
        if hasUnread
        {
            unreadMark = CAShapeLayer();
            unreadMark?.path = UIBezierPath(ovalIn: CGRect(x: (self.customView?.frame.width ?? 0) - 10, y: 0, width: 10, height: 10)).cgPath;
            unreadMark?.fillColor = UIColor.red.cgColor
            self.customView?.layer.addSublayer(unreadMark!)
        }
        else
        {
            unreadMark?.removeFromSuperlayer()
        }
        
    }
}

