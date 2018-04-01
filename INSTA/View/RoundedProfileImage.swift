//
//  RoundedProfileImage.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedProfileImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
    func updateView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
