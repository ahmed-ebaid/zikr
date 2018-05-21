//
//  AzkarViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 4/8/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import AVFoundation
import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var pageSelector: UISegmentedControl!
    @IBOutlet weak var playPause: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    
    var audioPlayer: AVAudioPlayer?
    let viewModel = ZikrQuranViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureAudioPlayer()
    }
    
    private func configureTableView() {
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
        audioSlider.maximumValue = Float(audioPlayer!.duration)
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let isPlaying = audioPlayer?.isPlaying else {
            return
        }
        
        if playPause.imageView?.image == #imageLiteral(resourceName: "play") {
            playPause.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playPause.imageView?.image = #imageLiteral(resourceName: "pause")
        } else {
            playPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
        
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
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
            playPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            audioSlider.value = 0.0
        }
    }
}
