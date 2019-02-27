//
//  HeaderStackCell.swift
//  Storybook
//
//  Created by muukii on 2019/01/26.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

final class HeaderStackCell : CodeBasedView {
  
  private let titleLabel = UILabel()
  
  private let detailLabel = UILabel()
  
  init() {
    super.init(frame: .zero)
    
    addSubview(titleLabel)
    addSubview(detailLabel)
    
    titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
    titleLabel.numberOfLines = 0
    
    detailLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    detailLabel.textColor = UIColor(white: 0, alpha: 0.4)
    detailLabel.numberOfLines = 0
    
    titleLabel.easy.layout([
      Top(.appSpace(4)),
      Trailing(.appSpace(4)),
      Leading(.appSpace(4)),
      ])
    
    detailLabel.easy.layout([
      Top(.appSpace(2)).to(titleLabel, .bottom),
      Trailing(.appSpace(4)),
      Leading(.appSpace(4)),
      Bottom(.appSpace(4))
      ])
  }
  
  func set(title: String) {
    titleLabel.text = title
  }
  
  func set(detail: String) {
    detailLabel.text = detail
  }

}
