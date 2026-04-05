# CatchTheKennyGame

An improved "Catch The Kenny" game built with Swift and UIKit.

This project started as a simple course exercise and was later refactored into a cleaner and more maintainable version. The app challenges the user to tap the visible Kenny as quickly as possible before time runs out, while keeping track of the highest score locally.

## About

This project is based on a hands-on app I built while taking a Udemy iOS development course.

The original version focused on learning the basics of:
- UIKit
- Storyboard-based UI development
- `IBOutlet` / `IBAction` connections
- `Timer` usage
- `UITapGestureRecognizer`
- Local persistence with `UserDefaults`

After building the original course version, I improved the project to make it cleaner, more reusable, and closer to a real portfolio project.

## Project Evolution

### Original Version

The first version of the project included:
- 9 separate `UIImageView` outlets for each Kenny
- 9 separate gesture recognizers
- Manual array creation for all Kenny image views
- Basic score and timer logic
- Local high score storage with `UserDefaults`
- A replay alert after the game ended

This version was useful for learning the fundamentals, but it contained repeated code and was harder to maintain.

### Improved Version

The final version includes:
- A single `IBOutlet` collection for all Kenny image views
- Cleaner UI setup with dedicated helper methods
- Safer and more modern random Kenny selection
- Better timer management
- Cleaner game lifecycle methods such as starting and ending the game
- Improved readability with constants and access control
- A more maintainable and professional `ViewController` structure
- A fix for layout behavior caused by hiding arranged subviews inside stack views
- A better visibility approach using `alpha` and interaction control instead of relying only on `isHidden`

## Tech Stack

- Swift
- UIKit
- Xcode
- Storyboard
- `Timer`
- `UITapGestureRecognizer`
- `UserDefaults`

## Features

- Tap the currently visible Kenny to earn points
- Countdown-based gameplay
- Random Kenny appearance during the game
- High score persistence with `UserDefaults`
- Replay option when the game ends
- Updated UI labels for time, score, and high score
- Cleaner Kenny management using an outlet collection

## Improvements Over the Original Course Project

Compared to the original course version, this project now includes:

- Replacing 9 separate image view outlets with a single outlet collection
- Removing repetitive gesture recognizer setup code
- Refactoring long `viewDidLoad()` logic into smaller helper methods
- Using constants for game duration, hide interval, and storage keys
- Safer timer invalidation and reset handling
- Better organization with `startGame()`, `endGame()`, and UI update helpers
- More modern and readable Swift style
- Preventing layout issues caused by hidden views inside stack views
- Preventing the same Kenny from feeling "stuck" in place during gameplay by improving the random appearance logic

## What I Practiced

With this project, I practiced:

- Building a simple game with UIKit
- Managing game state with timers
- Updating UI dynamically
- Working with `UIImageView` interactions
- Persisting simple data locally
- Refactoring beginner-level code into cleaner Swift code
- Improving readability and maintainability in a storyboard-based project

## Notes

- This project began as a course practice app and was later improved by me
- The main goal was not only to make the game work, but also to rewrite it in a cleaner and more professional way
- The project helped me understand the difference between a "working beginner solution" and a more maintainable implementation
- It also gave me practice with debugging UI layout and stack view behavior
