//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Buğrahan Umay Şafak on 4.04.2026.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var highScoreLabel: UILabel!
    @IBOutlet private var kennys: [UIImageView]!

    private enum Constants {
        static let gameDuration = 20
        static let hideInterval = 1.0
        static let highScoreKey = "highscore"
    }

    private var score = 0
    private var counter = Constants.gameDuration
    private var highScore = 0
    private var currentKennyIndex: Int?
    private var gameTimer: Timer?
    private var hideTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadHighScore()
        configureKennys()
        startGame()
    }

    deinit {
        gameTimer?.invalidate()
        hideTimer?.invalidate()
    }

    private func configureUI() {
        updateLabels()
        highScoreLabel.text = "Highscore: \(highScore)"
    }

    private func configureKennys() {
        kennys.forEach { imageView in
            imageView.alpha = 0.0
            imageView.isUserInteractionEnabled = false

            let recognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(increaseScore(_:))
            )
            imageView.addGestureRecognizer(recognizer)
        }
    }

    private func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: Constants.highScoreKey)
        highScoreLabel.text = "Highscore: \(highScore)"
    }

    private func updateLabels() {
        timeLabel.text = "\(counter)"
        scoreLabel.text = "Score: \(score)"
    }

    private func startGame() {
        score = 0
        counter = Constants.gameDuration
        currentKennyIndex = nil
        updateLabels()

        gameTimer?.invalidate()
        hideTimer?.invalidate()

        hideAllKennys()

        gameTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(countDown),
            userInfo: nil,
            repeats: true
        )

        hideTimer = Timer.scheduledTimer(
            timeInterval: Constants.hideInterval,
            target: self,
            selector: #selector(showRandomKenny),
            userInfo: nil,
            repeats: true
        )

        showRandomKenny()
    }

    private func hideAllKennys() {
        kennys.forEach { kenny in
            kenny.alpha = 0.0
            kenny.isUserInteractionEnabled = false
        }
    }

    @objc private func showRandomKenny() {
        hideAllKennys()

        guard !kennys.isEmpty else { return }

        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<kennys.count)
        } while kennys.count > 1 && newIndex == currentKennyIndex

        currentKennyIndex = newIndex

        let visibleKenny = kennys[newIndex]
        visibleKenny.alpha = 1.0
        visibleKenny.isUserInteractionEnabled = true
    }

    @objc private func increaseScore(_ sender: UITapGestureRecognizer) {
        guard let tappedKenny = sender.view as? UIImageView,
              tappedKenny.alpha == 1.0 else { return }

        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc private func countDown() {
        counter -= 1
        timeLabel.text = "\(counter)"

        if counter <= 0 {
            endGame()
        }
    }

    private func endGame() {
        gameTimer?.invalidate()
        hideTimer?.invalidate()
        gameTimer = nil
        hideTimer = nil

        hideAllKennys()

        if score > highScore {
            highScore = score
            highScoreLabel.text = "Highscore: \(highScore)"
            UserDefaults.standard.set(highScore, forKey: Constants.highScoreKey)
        }

        presentGameOverAlert()
    }

    private func presentGameOverAlert() {
        let alert = UIAlertController(
            title: "Time's Up",
            message: "Do you want to play again?",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .cancel)

        let replayAction = UIAlertAction(title: "Replay", style: .default) { [weak self] _ in
            self?.startGame()
        }

        alert.addAction(okAction)
        alert.addAction(replayAction)

        present(alert, animated: true)
    }
}

