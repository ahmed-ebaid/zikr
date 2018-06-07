import AVFoundation
import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var pageSelector: UISegmentedControl!
    @IBOutlet weak var playPause: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    
    enum PlaybuttonStatus {
        case play
        case pause
    }
    
    let viewModel = ZikrQuranViewModel()
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    var playButtonStatus: PlaybuttonStatus = .play
    var selectedCell: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureAudioPlayer()
    }
    
    private func configureTableView() {
//        tableView.estimatedRowHeight = 400
//        tableView.rowHeight = UITableViewAutomaticDimension
        let zikrCellNib = UINib(nibName: "ZikrTableViewCell", bundle: nil)
        tableView.register(zikrCellNib, forCellReuseIdentifier: "zikrCell")
    }
    
    private func configureAudioPlayer() {
        let sound = Bundle.main.url(forResource: "112", withExtension: "mp3")
        guard let player = try? AVAudioPlayer(contentsOf: sound!) else {
            return
        }
        audioPlayer = player
        audioPlayer?.delegate = self
        if let duration = audioPlayer?.duration.magnitude {
            audioSlider.maximumValue = Float(duration)
        }
        
        guard let isPlaying = audioPlayer?.isPlaying else {
            return
        }
        
        if isPlaying {
            playButtonStatus = .pause
        } else {
            playButtonStatus = .play
        }
    }
    
    @IBAction func sliderDragged(_ sender: UISlider) {
        guard let player = audioPlayer else {
            return
        }
        if player.isPlaying {
            player.currentTime = TimeInterval(sender.value)
        }
    }
    
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let isPlaying = audioPlayer?.isPlaying else {
            return
        }

        if isPlaying {
            audioPlayer?.pause()
            timer?.invalidate()
            playButtonStatus = .pause
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                self.audioSlider.value = Float((self.audioPlayer?.currentTime)!)
            }
            audioPlayer?.play()
            playButtonStatus = .play
        }
        
        switch playButtonStatus {
        case .play:
            playPause.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        case .pause:
            playPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    @IBAction func pageSelectorTapped(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

extension AzkarViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.morningZikrModels.count
    }
    
    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zikrCell") as! ZikrTableViewCell
        cell.delegate = self
        
        let zikrModel = pageSelector.selectedSegmentIndex == 0 ? viewModel.morningZikrModels[indexPath.row] : viewModel.eveningZikrModels[indexPath.row]
        
        cell.configureUI(zikrModel: zikrModel)
        return cell
    }
}

extension AzkarViewController: ZikrTableViewCellDelegate {
    func zikrTableViewCellPresentShareAvtivityController(cell: ZikrTableViewCell, text: [String]) {
        let activityController = UIActivityViewController(activityItems: text, applicationActivities: nil)
        activityController.setValue("Zikr application would like to share the following content with you", forKey: "Subject")
        present(activityController, animated: true)
    }
    
    func zikrTableViewRedrawCell(cell: ZikrTableViewCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension AzkarViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            timer?.invalidate()
            audioSlider.value = 0
            playPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
}
