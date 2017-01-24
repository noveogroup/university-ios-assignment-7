//
//  ViewController.swift
//  PingPong
//
//  Created by Kirill Asyamolov on 27/12/16.
//  Copyright © 2016 Kirill Asyamolov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    /*
     Enum that determines the current game state, it influences on the game logic and on the UI. Values:
     - initiating: graphics preparing
     - isPlaying: game is running, game steps are processing, ui is updating
     - stopped: game is reseted, everything is freezed
     - paused: everything is freezed, but the game could be continued
     - loosing: animation how the ball is going to collide with the ground when platfrom is lost (ball is active, platforms are not).
     in this state it's impossible to pause or stop the game
     */
    enum GameState {
        case initiating, playing, stopped, paused, loosing
    }
    
    enum BallDirection {
        case nw, ne, sw, se
        
        func isNorthDirection() -> Bool {
            switch self {
            case .nw, .ne:
                return true
            default:
                return false
            }
        }
        
        static func getRandom() -> BallDirection {
            let rand = arc4random_uniform(4)
            switch rand {
            case 0:
                return .nw
            case 1:
                return .ne
            case 2:
                return .sw
            default:
                return .se
            }
        }
    }
    
    // game constants
    private let platformSize = CGSize(width: 100, height: 10)
    private let ballSize = CGSize(width: 20, height: 20)
    private let platformSpeed = CGFloat(100.0)
    private let ballSpeed: CGFloat = 200.0
    private let platformPadding: CGFloat = 20.0
    
    // ui
    @IBOutlet weak var playGround: UIView!
    private var platform1: UIView!
    private var platform2: UIView!
    private var ball: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    // game mechanics
    private var ballPosition: CGPoint!
    private var platform1Position: CGPoint!
    private var platform2Position: CGPoint!
    
    private var ballDirection: BallDirection = .nw {
        didSet {
            switch ballDirection {
            case .nw:
                ballAngle = CGFloat(5.0 * M_PI / 4.0)
            case .ne:
                ballAngle = CGFloat(7.0 * M_PI / 4.0)
            case .sw:
                ballAngle = CGFloat(3.0 * M_PI / 4.0)
            case .se:
                ballAngle = CGFloat(1.0 * M_PI / 4.0)
            }
        }
    }
    private var ballAngle: CGFloat = 0.0
    
    private var gameState: GameState = .initiating {
        didSet {
            DispatchQueue.main.async {
                self.playButton.isEnabled = false
                self.pauseButton.isEnabled = false
                self.stopButton.isEnabled = false
                
                switch self.gameState {
                case .playing:
                    self.pauseButton.isEnabled = true
                    self.stopButton.isEnabled = true
                case .paused:
                    self.playButton.isEnabled = true
                    self.stopButton.isEnabled = true
                case .stopped:
                    self.playButton.isEnabled = true
                default:
                    break
                }
            }
        }
    }
    
    // utils
    private var displayLink: CADisplayLink?
    private let concurentQueue = DispatchQueue(label: "com.noveogroup.pingpong", attributes: .concurrent)
    private var previousTime = 0.0
    
    
    //MARK: ViewController system handlers
    override func viewDidLoad() {
        super.viewDidLoad()
        gameState = .initiating
        initGraphicParts()
        stopGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetGame()
    }
    
    
    //MARK: ui initialization
    private func initGraphicParts() {
        playGround.backgroundColor = UIColor.green
        
        platform1 = createPlatform()
        playGround.addSubview(platform1)
        
        platform2 = createPlatform()
        playGround.addSubview(platform2)
        
        ball = UIView()
        ball.frame = CGRect(origin: CGPoint(x: playGround.frame.width * 0.5, y: playGround.frame.height * 0.5), size: ballSize)
        ball.layer.cornerRadius = ballSize.width * 0.5
        ball.backgroundColor = UIColor.black
        //ball.center = CGPoint(x: ballSize.width * 0.5, y: ballSize.height * 0.5)
        playGround.addSubview(ball)
    }
    
    private func createPlatform() -> UIView {
        let platform = UIView()
        platform.frame = CGRect(origin: CGPoint(x: 0, y:0), size: platformSize)
        platform.layer.cornerRadius = 3
        platform.backgroundColor = UIColor.brown
        
        return platform
    }
    
    
    func gameStep() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        let deltaTime = CGFloat(currentTime - previousTime)
        
        // move a ball
        ballPosition.x += cos(ballAngle) * ballSpeed * deltaTime
        ballPosition.y += sin(ballAngle) * ballSpeed * deltaTime
        
        // check for collision with walls
        // with the left wall
        if ballPosition.x <= 0 {
            ballDirection = (ballDirection == .nw ? .ne : .se)
            // with the right wall
        } else if ballPosition.x + ballSize.width > playGround.frame.width {
            ballDirection = (ballDirection == .ne ? .nw : .sw)
        }
        //with top and bottom wall
        if ballPosition.y <= 0 {
            stopGame()
        } else if ballPosition.y + ballSize.height > playGround.frame.height {
            stopGame()
        }
        
        if gameState == .playing {
            let ballMidX = ballPosition.x + ballSize.width * 0.5
            // check for collision with platforms
            // with the top platform
            if ballPosition.y <= platform1.frame.maxY {
                if (ballMidX > platform1.frame.minX) && (ballMidX < platform1.frame.maxX) {
                    ballDirection = (ballDirection == .ne ? .se : .sw)
                } else {
                    gameState = .loosing
                }
                // with the bottom platform
            } else if ballPosition.y + ballSize.height >= platform2.frame.minY {
                if (ballMidX > platform2.frame.minX) && (ballMidX < platform2.frame.maxX) {
                    ballDirection = (ballDirection == .se ? .ne : .nw)
                } else {
                    gameState = .loosing
                }
            }
            
            // platfroms moving
            var currentPlatformPosition: CGPoint = ballDirection.isNorthDirection() ? platform1Position :       platform2Position
            let platformMidX = currentPlatformPosition.x + platformSize.width * 0.5
            
            let maxPlatformDeltaX = platformSpeed * deltaTime
            let ballAndPlatfromDeltaX = abs(platformMidX - ballMidX)
            let platformDeltaX = min(maxPlatformDeltaX, ballAndPlatfromDeltaX)
            
            if platformMidX < ballMidX {
                currentPlatformPosition.x = min(currentPlatformPosition.x + platformDeltaX, playGround.frame.width - platformSize.width)
            } else {
                currentPlatformPosition.x = max(currentPlatformPosition.x - platformDeltaX, 0)
            }
            
            if ballDirection.isNorthDirection() {
                platform1Position = currentPlatformPosition
            } else {
                platform2Position = currentPlatformPosition
            }
        }
        
        previousTime = currentTime
    }
    
    func updateUI() {
        ball.frame.origin = ballPosition
        platform1.frame.origin = platform1Position
        platform2.frame.origin = platform2Position
    }
    
    
    // MARK: Game states controller
    func startGame() {
        continueGame()
    }
    
    func stopGame() {
        gameState = .stopped
        displayLink?.remove(from: .current, forMode: .defaultRunLoopMode)
        displayLink = nil
        resetGame()
        
        //this method could be called from a custom queue
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func resetGame() {
        ballDirection = BallDirection.getRandom()
        
        // init platfroms and ball start positions
        ballPosition = CGPoint(x: (playGround.frame.width - ballSize.width) * 0.5, y: (playGround.frame.height - ballSize.height) * 0.5)
        platform1Position = CGPoint(x: (playGround.frame.width - platformSize.width) * 0.5, y: 20)
        platform2Position = CGPoint(x: (playGround.frame.width - platformSize.width) * 0.5, y: playGround.frame.height - platformSize.height - 20)
    }
    
    func pauseGame() {
        gameState = .paused
        displayLink?.remove(from: .current, forMode: .defaultRunLoopMode)
        displayLink = nil
    }
    
    func continueGame() {
        gameState = .playing
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateUI))
        displayLink?.add(to: .current, forMode: .defaultRunLoopMode)
        
        concurentQueue.async {
            while self.gameState == .playing || self.gameState == .loosing {
                self.gameStep()
            }
        }
        previousTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    // MARK: Button listeners
    @IBAction func buttonPlayClicked(_ sender: AnyObject) {
        if gameState == .stopped {
            startGame()
        } else if gameState == .paused{
            continueGame()
        }
    }
    
    @IBAction func buttonPauseClicked(_ sender: AnyObject) {
        pauseGame()
    }
    
    @IBAction func buttonStopClicked(_ sender: AnyObject) {
        stopGame()
    }
    
    
}

