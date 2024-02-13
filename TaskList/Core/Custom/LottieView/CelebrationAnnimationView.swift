//
//  CelebrationAnnimationView.swift
//  TaskList
//
//  Created by MacBoobPro on 06.02.24.
//

import UIKit
import Lottie

class CelebrationAnnimationView: UIView {
    var animationView: LottieAnimationView
    
    init(fileName: String) {
        let animation = LottieAnimation.named(fileName)
        self.animationView = LottieAnimationView(animation: animation)
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleToFill
        addSubview(animationView)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(
                equalTo: trailingAnchor),
            animationView.topAnchor.constraint(
                equalTo: topAnchor),
            animationView.bottomAnchor.constraint(
                equalTo: bottomAnchor)
        ])
    }
    
    func play(complention: @escaping (Bool) -> Void) {
        animationView.play(completion: complention)
    }
    
}
