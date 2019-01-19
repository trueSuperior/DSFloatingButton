//
//  DSFloatingButton.swift
//  DSFloatingButton
//
//  Created by Yuma Ikeda on 2018/12/19.
//  Copyright © 2018 UMA. All rights reserved.
//

import UIKit

@IBDesignable
open class DSFloatingButton: UIButton {
    
    open override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    /// View corner radius
    @IBInspectable
    open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        }
    }
    
    /// Use corner radius. By default, radius will use the bounds.height / 2
    @IBInspectable
    open var useCornerRadius: Bool = false {
        didSet {
            layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        }
    }
    
    /// Shadow color. if set nil will use background color.
    @IBInspectable
    open var shadowColor: UIColor? {
        didSet {
            layer.shadowColor = shadowColor?.cgColor ?? backgroundColor?.cgColor
        }
    }
    
    /// Shadow opacity. 0 ~ 1
    @IBInspectable
    open var shadowOpacity: Float = 0.8 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    /// Shadow offset.
    @IBInspectable
    open var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    /// Shadow radius.
    @IBInspectable
    open var shadowRadius: CGFloat = 8 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    /// Color of gradient start.
    @IBInspectable
    open var gradientStartColor: UIColor = .clear {
        didSet {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.colors = colors
        }
    }
    
    /// Color of gradient end.
    @IBInspectable
    open var gradientEndColor: UIColor = .clear {
        didSet {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.colors = colors
        }
    }
    
    /// Point of gradient start.
    @IBInspectable
    open var gradientStartPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.startPoint = gradientStartPoint
        }
    }
    
    /// Point of gradient end.
    @IBInspectable
    open var gradientEndPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            guard let gradientLayer = self.layer as? CAGradientLayer else { return }
            gradientLayer.endPoint = gradientEndPoint
        }
    }
    
    /// Enable animate interaction.
    @IBInspectable
    open var animateInteraction: Bool = true
    
    /// Start animation duration.
    open var beginAnimationDuration: Double = 0.2
    
    /// End animation duration.
    open var endAnimationDuration: Double = 0.25
    
    /// Animation Spring velocity.
    open var initialSpringVelocity: Float = 6.0
    
    /// Animation Spring Damping.
    open var usingSpringWithDamping: Float = 0.2
    
    /// Animation scale.
    open var animationScale: CGFloat = 0.95
    
    /// Touch up insede event handler.
    open var tap: ((DSFloatingButton) -> Void)?
    
    /// Variable to see if animating.
    private (set) open var isAnimating = false
    
    // Gradient colors.
    private var colors: [CGColor] {
        return [gradientStartColor.cgColor, gradientEndColor.cgColor]
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
        isExclusiveTouch = true
    }
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        layer.shadowColor = shadowColor?.cgColor ?? backgroundColor?.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        gradientLayer.colors = colors
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
    }
    
    @objc func onTouchUpInside(){
        tap?(self)
    }
}

// Animation
extension DSFloatingButton {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.animateInteraction {
            isAnimating = true
            UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                self.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
            }) { (complete) in
                self.isAnimating = false
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap:UITouch = touches.first!
        let point = tap.location(in: self)
        if !self.bounds.contains(point) {
            if self.animateInteraction {
                isAnimating = true
                UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                    self.transform = .identity
                }) { (complete) in
                    self.isAnimating = false
                }
            }
        } else {
            if self.animateInteraction{
                isAnimating = true
                UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                    self.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
                }) { (complete) in
                    self.isAnimating = false
                }
            }
        }
        super.touchesMoved(touches, with: event)
        
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.animateInteraction {
            isAnimating = true
            UIView.animate(withDuration: self.endAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(self.usingSpringWithDamping),
                           initialSpringVelocity: CGFloat(self.initialSpringVelocity),
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            }) { (complete) in
                self.isAnimating = false
            }
        }
        super.touchesEnded(touches, with: event)
        
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.animateInteraction {
            isAnimating = true
            UIView.animate(withDuration: self.endAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(self.usingSpringWithDamping),
                           initialSpringVelocity: CGFloat(self.initialSpringVelocity),
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            }) { (complete) in
                self.isAnimating = false
            }
        }
        super.touchesCancelled(touches, with: event)
    }
}
