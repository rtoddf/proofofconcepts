import UIKit
import AVFoundation

// things to do
/*
 1 - at the end of the video, turn the pause button back to play - DONE
 2 - add a mute and unmute button
 3 - once the video starts playing, fade out the controls
 4 - it user taps on the video while playing, fade the controls back in
 5 - make sure you remove the observers - removeObserver(self, forKeyPath: #keyPath(PlayerViewController.player.currentItem.duration), context: &playerViewControllerKVOContext)
 6 - at the end of hte video, change the play button to replay. If the user clicks it - it goes back to 00:00
 7 - is there a way to show how much of the video is loaded???
 
 https://developer.apple.com/library/archive/samplecode/AVFoundationSimplePlayer-iOS/Listings/Swift_AVFoundationSimplePlayer_iOS_PlayerViewController_swift.html
 */

class VideoCell:BaseCell {
    override func setupViews() {
        super.setupViews()
        
        setupPlayerView()
        setupGradientLayer()
        setupUIElements()
    }
    
    func setupUIElements(){
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoCurrentTimeLabel)
        videoCurrentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        videoCurrentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        videoCurrentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoCurrentTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: 0).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: videoCurrentTimeLabel.rightAnchor, constant: 0).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //        controlsContainerView.addSubview(dismissViewButton)
        //        dismissViewButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        //        dismissViewButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        //        dismissViewButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        //        dismissViewButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    @objc func playw() {
        self.isPlaying = false
        self.pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
//    func stopVideo(){
//        player?.pause()
//    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.0]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    let activityIndicatorView:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton:UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "pause")
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    var isPlaying:Bool = false
    
    @objc func handlePause(){
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    let controlsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoCurrentTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoLengthLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoSlider:UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .orange
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSliderChanged), for: .valueChanged)
        
        return slider
    }()
    
    //    let dismissViewButton:UIButton = {
    //        let btn = UIButton(type: .system)
    //        let image = UIImage(named: "dismiss")
    //        btn.setImage(image, for: .normal)
    //        btn.tintColor = .white
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //        btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    //        return btn
    //    }()
    
    @objc func handleSliderChanged(){
        guard let duration  = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float(totalSeconds) * videoSlider.value
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            // do other things
        })
    }
    
    @objc func dismissView(){
        player?.pause()
        //        player?.isMuted = true
    }
    
    var player:AVPlayer?
    
    func setupPlayerView(){
        let urlString = "http://rtodd.net/swift/video/ready_player_one.mp4"
        guard let url = NSURL(string: urlString) else { return }
        
        player = AVPlayer(url: url as URL)
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        player?.play()
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        // can end be done hte same way?
        
        // track player progress
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds) / 60)
            self.videoCurrentTimeLabel.text = "\(minutesString):\(secondsString)"
            
            // move the slider
            guard let duration = self.player?.currentItem?.duration else { return }
            let durationSeconds = CMTimeGetSeconds(duration)
            self.videoSlider.value = Float(seconds / durationSeconds)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(playw), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        //            player?.actionAtItemEnd(
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            // this gives you a CMTime reference
            guard let duration = player?.currentItem?.duration else { return }
            let seconds = CMTimeGetSeconds(duration)
            
            let minuteText = String(format: "%02d", Int(seconds) / 60)
            let secondsText = Int(seconds) % 60
            
            videoLengthLabel.text = "\(minuteText):\(secondsText)"
        }
    }
    
}
