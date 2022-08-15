//
//  GameView.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit
import Domain

final class GameView: BoundView<GameViewModel> {
    private let imageConfiguration = UIImage.SymbolConfiguration(
        pointSize: 30,
        weight: .bold,
        scale: .default
    )
    
    private lazy var correctImage = UIImage(
        systemName: "checkmark.circle.fill",
        withConfiguration: imageConfiguration
    )
    
    private lazy var wrongImage = UIImage(
        systemName: "xmark.circle.fill",
        withConfiguration: imageConfiguration
    )
    
    private(set) lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .caption2)
        label.text = viewModel.scoreLabelText
        label.textAlignment = .right
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var spanishLabelWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private(set) lazy var spanishLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var englishLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [spanishLabelWrapper, englishLabel]
        )
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) lazy var correctButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.setImage(correctImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var wrongButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.setImage(wrongImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var spanishLabelTopAnchor: NSLayoutConstraint!
    private var contentViewSize: CGSize!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentViewSize = contentStackView.frame.size
    }
    
    override func setupViews() {
        super.setupViews()
        
        spanishLabelWrapper.addSubview(spanishLabel)
        
        wrapButtonsInsideView().forEach({
            buttonStackView.addArrangedSubview($0)
        })
        
        addSubview(scoreLabel)
        addSubview(contentStackView)
        addSubview(buttonStackView)
    }
    
    override func setupLayouts() {
        super.setupLayouts()
        
        spanishLabelTopAnchor = spanishLabel.topAnchor.constraint(
            equalTo: spanishLabelWrapper.topAnchor
        )
        spanishLabelTopAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            spanishLabel.leadingAnchor.constraint(
                equalTo: spanishLabelWrapper.leadingAnchor
            ),
            spanishLabel.trailingAnchor.constraint(
                equalTo: spanishLabelWrapper.trailingAnchor
            ),
            
            spanishLabelWrapper.heightAnchor.constraint(
                equalTo: contentStackView.heightAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            scoreLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 10
            ),
            scoreLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -10
            )
        ])

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: scoreLabel.bottomAnchor,
                constant: 5
            ),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(
                equalTo: buttonStackView.topAnchor,
                constant: -5
            )
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            )
        ])
    }
    
    private func wrapButtonsInsideView() -> [UIView] {
        let correctButtonWrapper = UIView()
        correctButtonWrapper.isUserInteractionEnabled = true
        correctButtonWrapper.translatesAutoresizingMaskIntoConstraints = false
        correctButtonWrapper.addSubview(correctButton)
        
        let wrongButtonWrapper = UIView()
        wrongButtonWrapper.isUserInteractionEnabled = true
        wrongButtonWrapper.translatesAutoresizingMaskIntoConstraints = false
        wrongButtonWrapper.addSubview(wrongButton)
        
        NSLayoutConstraint.activate([
            correctButtonWrapper.heightAnchor.constraint(
                equalTo: correctButton.heightAnchor
            ),
            correctButton.centerXAnchor.constraint(
                equalTo: correctButtonWrapper.centerXAnchor
            ),
            correctButton.centerYAnchor.constraint(
                equalTo: correctButtonWrapper.centerYAnchor
            ),
            wrongButtonWrapper.heightAnchor.constraint(
                equalTo: wrongButton.heightAnchor
            ),
            wrongButton.centerXAnchor.constraint(
                equalTo: wrongButtonWrapper.centerXAnchor
            ),
            wrongButton.centerYAnchor.constraint(
                equalTo: wrongButtonWrapper.centerYAnchor
            )
        ])
        
        return [correctButtonWrapper, wrongButtonWrapper]
    }

    func startSpanishWordAnimation() {
        let animationDuration: TimeInterval = viewModel.gameConfiguration
            .timeToAnswerQuestion
        let animationDelay: TimeInterval = 0
        
        UIView.animate(
            withDuration: animationDuration,
            delay: animationDelay,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                let contentViewHeight = self?.contentViewSize.height ?? 0
                self?.spanishLabelTopAnchor.constant += contentViewHeight
                self?.layoutIfNeeded()
            },
            completion: { [weak self] (isAnimationFinished) in
                guard isAnimationFinished else { return }
                self?.viewModel.questionTimedOut()
            }
        )
    }
    
    func stopSpanishWordAnimation() {
        spanishLabel.layer.removeAllAnimations()
    }
    
    func reset() {
        englishLabel.text = ""
        spanishLabel.text = ""
        scoreLabel.text = ""
        resetTopAnchorConstraint()
    }
    
    func resetTopAnchorConstraint() {
        spanishLabelTopAnchor.constant = 0
    }
    
    func updateScoreLabel() {
        scoreLabel.text = viewModel.scoreLabelText
    }
    
    func updateWordPairLabels(with wordPair: WordPair) {
        englishLabel.text = wordPair.englishWord
        spanishLabel.text = wordPair.spanishWord
    }
}
