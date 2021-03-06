//
//  AzkarViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import AVFoundation
import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageSelector: UISegmentedControl!
    @IBOutlet var playPause: UIButton!
    @IBOutlet var audioSlider: UISlider!

    var tappedIndexPath: IndexPath?
    var controlRowIndexPath: IndexPath?
    
    let viewModel: ZikrQuranViewModel

    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    var playButtonStatus: PlayButtonState = .play
    var selectedCell: IndexPath?

    enum PlayButtonState {
        case play
        case pause
    }

    init(viewModel: ZikrQuranViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AzkarViewController", bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerCells()
        configureAudioPlayer()
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 314
    }

    private func registerCells() {
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
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
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

    @IBAction func pageSelectorTapped(_: UISegmentedControl) {
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
        if let index = controlRowIndexPath, index == indexPath {
            let controlCell = tableView.dequeueReusableCell(withIdentifier: "zikrActionsCell", for: index) as! ZikrActionsTableViewCell
            return controlCell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "zikrCell", for: indexPath) as! ZikrTableViewCell
        let rowOfDataCell = viewModel.getDataCellRow(using: controlRowIndexPath, tappedIndexPath: indexPath)
        let zikrModel = pageSelector.selectedSegmentIndex == 0 ? viewModel.morningZikrModels[rowOfDataCell] : viewModel.eveningZikrModels[rowOfDataCell]
        cell.configureUI(zikrModel: zikrModel)
        return cell
    }
}

extension AzkarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var deletedRowIndexPath: IndexPath?
        
        if let controlIndex = controlRowIndexPath {
            if controlIndex == IndexPath(row: indexPath.row + 1, section: indexPath.section) {
                controlRowIndexPath = nil
            } else {
                controlRowIndexPath = viewModel.getControlCellIndexPath(using: controlIndex, tappedIndexPath: indexPath)
            }
            deletedRowIndexPath = controlIndex
        } else {
            tappedIndexPath = indexPath
            controlRowIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
        
        tableView.beginUpdates()
        
        if let deleteIndex = deletedRowIndexPath {
            tableView.deleteRows(at: [deleteIndex], with: .none)
        }
        
        if let controlIndex = controlRowIndexPath {
            tableView.insertRows(at: [controlIndex], with: .none)
        }
        
        tableView.endUpdates()
    }
}

extension AzkarViewController: ZikrTableViewCellDelegate {
    func zikrTableViewCellPresentShareAvtivityController(cell _: ZikrTableViewCell, text: [String]) {
        let activityController = UIActivityViewController(activityItems: text, applicationActivities: nil)
        activityController.setValue("Zikr application would like to share the following content with you", forKey: "Subject")
        present(activityController, animated: true)
    }

    func zikrTableViewRedrawCell(cell _: ZikrTableViewCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension AzkarViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            timer?.invalidate()
            audioSlider.value = 0
            playPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            audioSlider.value = 0.0
        }
    }
}
