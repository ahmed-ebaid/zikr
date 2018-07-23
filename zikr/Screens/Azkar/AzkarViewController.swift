import AVFoundation
import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var pageSelector: UISegmentedControl!
    @IBOutlet weak var playPause: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    
    var tappedIndexPath: IndexPath?
    var controlRowIndexPath: IndexPath?
    let viewModel: ZikrQuranViewModel
    
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    var playButtonStatus: PlaybuttonStatus = .play
    var selectedCell: IndexPath?
    
    enum PlaybuttonStatus {
        case play
        case pause
    }
    
    init(viewModel: ZikrQuranViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AzkarViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureAudioPlayer()
    }
    
    private func configureTableView() {
        let zikrCellNib = UINib(nibName: "ZikrTableViewCell", bundle: nil)
        tableView.register(zikrCellNib, forCellReuseIdentifier: "zikrCell")
        
        let zikrActionNib = UINib(nibName: "ZikrActionsTableViewCell", bundle: nil)
        tableView.register(zikrActionNib, forCellReuseIdentifier: "zikrActionsCell")

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
    
    @IBAction func audioSliderValueChanged(_ sender: UISlider) {
        audioPlayer?.currentTime =  Double(sender.value)
    }
    
}

extension AzkarViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return controlRowIndexPath == nil ? viewModel.morningZikrModels.count : viewModel.morningZikrModels.count + 1
    }
    
    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zikrCell") as! ZikrTableViewCell
        
        if controlRowIndexPath != nil {
            let actionCell = tableView.dequeueReusableCell(withIdentifier: "zikrActionsCell") as! ZikrActionsTableViewCell
            return actionCell
        }
        
        let zikrModel = pageSelector.selectedSegmentIndex == 0 ? viewModel.morningZikrModels[indexPath.row] : viewModel.eveningZikrModels[indexPath.row]
        
        cell.configureUI(zikrModel: zikrModel)
        return cell
    }
}

extension AzkarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = tappedIndexPath, index == indexPath {
            tableView.deselectRow(at: index, animated: false)
        }
        
        var indexPathToDelete: IndexPath?
        
        if let index = controlRowIndexPath{
            indexPathToDelete = index
        }
        

        if let index = tappedIndexPath, index == indexPath {
            tappedIndexPath = nil
            controlRowIndexPath = nil
        } else {
            tappedIndexPath = indexPath
            controlRowIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
        
        tableView.beginUpdates()
        
        if let index = indexPathToDelete {
            tableView.deleteRows(at: [index], with: .automatic)
        }
        
        if let index = controlRowIndexPath {
            tableView.insertRows(at: [index], with: .automatic)
        }
        
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let index = controlRowIndexPath, index == indexPath {
            return tappedIndexPath
        }
        return indexPath
    }
}

extension AzkarViewController: ZikrTableViewCellDelegate {
    func zikrTableViewCellPresentShareAvtivityController(cell: ZikrTableViewCell, text: [String]) {
        let activityController = UIActivityViewController(activityItems: text, applicationActivities: nil)
        activityController.setValue("Zikr application would like to share the following content with you", forKey: "Subject")
        present(activityController, animated: true)
    }
    
    func zikrTableViewRedrawCell(cell: ZikrTableViewCell) {
//        tableView.beginUpdates()
//        tableView.endUpdates()
    }
}

extension AzkarViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            timer?.invalidate()
            audioSlider.value = 0
            playPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            audioSlider.value = 0.0
        }
    }
}
