//
//  NotePage.swift
//  TakeItEasy
//
//  Created by Mihir Ghosh on 6/15/22.
//

import UIKit
import Speech

class NotePage: UIViewController {

    var note : NoteBook?
    var originalTitle: String = ""
    var originalDesc: String = ""

    @IBOutlet weak var pageTitle: UITextField!
    @IBOutlet weak var pageDesc: UITextView!
    
    //for speech functionality
    let audioEngine = AVAudioEngine()
    let speechRecog = SFSpeechRecognizer()
    let bufferRecogReq = SFSpeechAudioBufferRecognitionRequest()
    var recogTask : SFSpeechRecognitionTask!
    var isStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.text = originalTitle
        pageDesc.text = originalDesc
    }
    
    
    
    @IBAction func saveEdit(_ sender: Any) {
        var nTitle = pageTitle.text
        var nDesc = pageDesc.text
        
        print(originalTitle, nTitle, nDesc)
        if(nTitle != nil && nDesc != nil){
            if (!nTitle!.isEmpty && !nDesc!.isEmpty){
                if(nTitle! != "" && nDesc! != ""){
                    if originalTitle != ""{
                        Helper.helper.editNote(titleValue: originalTitle, cngtitle: nTitle!, noteValue: nDesc!)
                        originalTitle = ""
                    }
                    else{
                        Helper.helper.addNote(noteValue: nDesc!, titleValue: nTitle!)
                    }
                    //self.dismiss(animated: true, completion: nil)
                    navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func startSpeechRecog(){
        let inputNode = audioEngine.inputNode
        let recordFile = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFile){
            buffer, _ in
            self.bufferRecogReq.append(buffer)
        }
        audioEngine.prepare()
        do{
            try audioEngine.start()
        }
        catch{
            print("error")
        }
        recogTask = speechRecog?.recognitionTask(with: bufferRecogReq, resultHandler: {
            resp, error in
            guard let res = resp else{
                print(error)
                return
            }
            let msg = resp?.bestTranscription.formattedString
            self.pageDesc.text = msg
        })
        isStart = true
    }
    
    func cancellSpeech(){
        recogTask.finish()
        recogTask.cancel()
        recogTask = nil
        bufferRecogReq.endAudio()
        audioEngine.stop()
        if audioEngine.inputNode.numberOfInputs > 0{
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        isStart = false
    }
    
    @IBAction func recordNote(_ sender: UIButton) {
        if isStart{
            cancellSpeech()
            sender.setTitle("start", for: .normal)
        }
        else{
            startSpeechRecog()
            sender.setTitle("stop", for: .normal)
        }
    }
    
    

}

