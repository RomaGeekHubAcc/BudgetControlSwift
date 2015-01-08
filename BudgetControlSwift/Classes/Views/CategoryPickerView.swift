//
//  CategoryPickerView.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/8/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//


import UIKit

class CategoryPickerView: UIView {
    
    func viewWithFrame(frame:CGRect, name:String, iconName:String) {
        self.frame = frame;
        var iconImgView: UIImageView = UIImageView(frame: CGRect(x: 16, y: 5, width: 30, height: 30));
        iconImgView.image = UIImage(named: iconName);
        iconImgView.contentMode = UIViewContentMode.ScaleAspectFit;
        self.addSubview(iconImgView);
        
        
        var labelFrame = CGRect(
            x: iconImgView.frame.origin.x + iconImgView.frame.size.width + 10,
            y: (self.frame.height - 36)/2,
            width: self.frame.size.width - (iconImgView.frame.origin.x + iconImgView.frame.size.width + 20),
            height: 36 );
        
        var nameLabel: UILabel = UILabel(frame: labelFrame);
        nameLabel.textAlignment = NSTextAlignment.Center;
        nameLabel.font = UIFont(name: "HelveticaNeue", size: 22);
        nameLabel.text = name;
        self.addSubview(nameLabel);
    }
    
}
