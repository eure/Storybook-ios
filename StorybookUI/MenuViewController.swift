//
//  MenuViewController.swift
//  Storybook
//
//  Created by muukii on 2019/01/25.
//  Copyright © 2019 eure. All rights reserved.
//

import UIKit

import StorybookKit

final class MenuViewController : CodeBasedViewController {
  
  private let stackScrollView = StackScrollView()
  
  private let menuDescriptor: StorybookMenuDescriptor
  
  init(menuDescriptor: StorybookMenuDescriptor) {
    
    self.menuDescriptor = menuDescriptor
    
    super.init()
    
    title = "Storybook"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    view.addSubview(stackScrollView)
    stackScrollView.easy.layout(Edges())
    
    do {
      
      let views: [UIView] = menuDescriptor.sections.flatMap { section in
        [
          SectionCell(title: section.title) { },
          SeparatorView(leftMargin: .appSpace(4), rightMargin: 0, backgroundColor: .white, separatorColor: UIColor(white: 0, alpha: 0.1))
          ] +
          section.items.flatMap { item in
            [
              ItemCell(title: item.title) { [weak self] in
                self?.showDetailViewController(StackScrollViewController(descriptor: item), sender: self)
              },
              SeparatorView(leftMargin: .appSpace(8), rightMargin: 0, backgroundColor: .white, separatorColor: UIColor(white: 0, alpha: 0.1))
            ]
        }
      }
      
      stackScrollView.append(views: views)
      
    }
      
  }
}

extension MenuViewController {
  
  class HighlightStackCell : Element.TapStackCell {
    
    override init() {
      super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
      didSet {
        
        guard oldValue != isHighlighted else { return }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
          
          if self.isHighlighted {
            
            self.backgroundColor = self.backgroundColor?.add(hue: 0, saturation: 0, brightness: -0.1, alpha: 0)
          } else {
            
            self.backgroundColor = self.backgroundColor?.add(hue: 0, saturation: 0, brightness: +0.1, alpha: 0)
          }
        }) { _ in
        }
      }
    }
  }
  
  final class SectionCell : Element.TapStackCell {
    
    private let titleLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    convenience init(title: String, didTap: @escaping () -> Void = {}) {
      self.init()
      set(title: title)
      
      rx.tap.asDriver().drive(onNext: didTap).disposed(by: disposeBag)
    }
    
    override init() {
      super.init()
      
      titleLabel.numberOfLines = 0
      titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
      
      backgroundColor = .white
      
      addSubview(titleLabel)
      
      titleLabel.easy.layout(
        Edges(.appSpace(4)),
        Height(>=16)
      )
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
      titleLabel.text = title
    }
    
  }
  
  final class ItemCell : HighlightStackCell {
    
    private let titleLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    
    convenience init(title: String, didTap: @escaping () -> Void = {}) {
      self.init()
      set(title: title)
      
      rx.tap.asDriver().drive(onNext: didTap).disposed(by: disposeBag)
    }
    
    override init() {
      super.init()
      
      titleLabel.numberOfLines = 0
      titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
      
      backgroundColor = .white
      
      addSubview(titleLabel)
      
      titleLabel.easy.layout(
        Top(.appSpace(4)),
        Trailing(.appSpace(4)),
        Leading(.appSpace(8)),
        Bottom(.appSpace(4)),
        Height(>=16)
      )
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
      titleLabel.text = title
    }
    
  }

}
