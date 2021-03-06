//
//  ViewController.swift
//  SampleSystemSound
//
//  Created by Kazunori Aoki on 2021/03/16.
//

import UIKit
import AudioToolbox
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var sounds: [String]? = nil
    let path = "/System/Library/Audio/UISounds/"

    // 参考：https://github.com/TUNER88/iOSSystemSoundsLibrary
    let soundList = [1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1050,1051,1052,1053,1054,1055,1057,1070,1071,1072,1073,1074,1075,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1150,1151,1152,1153,1154,1200,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1254,1255,1256,1257,1258,1259,1300,1301,1302,1303,1304,1305,1306,1307,1308,1309,1310,1311,1312,1313,1314,1315,1320,1321,1322,1323,1324,1325,1326,1327,1328,1329,1330,1331,1332,1333,1334,1335,1336,1350,1351,4095]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
            tableView.autoresizingMask = [
              .flexibleWidth,
              .flexibleHeight
            ]
            tableView.delegate = self
            tableView.dataSource = self
            self.view.addSubview(tableView)

            return tableView
        }()

        do {
            self.sounds = try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
        }
        print(self.sounds!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
      ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")

        cell.textLabel?.text = self.sounds![indexPath.row]

      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playSound(soundId: self.sounds![indexPath.row])
    }
    
    func playSound(soundId: String) {
        
        var soundIdRing:SystemSoundID = 0
        let soundUrl = NSURL(fileURLWithPath: self.path + soundId)
        print(soundUrl)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundIdRing)
        print(soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
    }
}

